require 'rails_helper'

describe BlogSetting, :type => :model do
  #it { should validate_uniqueness_of(:key) }

  describe ".settings" do
    before(:each) do
      BlogSetting.class_eval do
        @@settings = nil
      end

      settings = double('BlogSetting')
      allow(BlogSetting).to receive(:all).and_return(settings)
      allow(settings).to receive(:inject).and_return({})
    end

    context "get the setting in the first time" do
      it "hits database for the first time" do
        expect(BlogSetting).to receive(:all)
        BlogSetting.settings
      end
    end

    context "does not hit database in the second time" do
      it "does not hit database after that" do
        expect(BlogSetting).to receive(:all).once

        BlogSetting.settings
        BlogSetting.settings
      end
    end
  end

  describe "dynamic method" do
    let!(:blog_title) { create(:blog_setting, key: :blog_title, value: 'A') }

    it "gets blog title" do
      expect(BlogSetting.blog_title).to eq('A')
    end
  end

  describe "#restart_setting" do
    let!(:blog_setting) { create(:blog_setting) }

    it 'calls restart_setting after save' do
      blog_setting.value = 'Updated Value'

      expect(blog_setting).to receive(:restart_setting)
      blog_setting.save!
    end
  end
end

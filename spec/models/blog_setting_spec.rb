require 'rails_helper'

describe BlogSetting, :type => :model do
  it { should validate_uniqueness_of(:key) }

  describe ".settings" do
    before(:each) do
      BlogSetting.class_eval do
        @@setting = nil
      end

      settings = double('BlogSetting')
      allow(BlogSetting).to receive(:all).and_return(settings)
      allow(settings).to receive(:inject).and_return({})
    end

    it "hits database for the first time" do
      expect(BlogSetting).to receive(:all)
      expect(BlogSetting.settings).to eq({})
    end

    it "does not hit database after that" do
      expect(BlogSetting).to receive(:all).once

      BlogSetting.settings
      BlogSetting.settings
    end
  end
end

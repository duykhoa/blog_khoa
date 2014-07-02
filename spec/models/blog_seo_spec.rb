require 'rails_helper'

describe BlogSeo, :type => :model do
  it { should validate_presence_of(:value) }

  describe ".metatags" do
    let!(:blog_seo) { create(:blog_seo) }
    before do
      blog_seo = double('BlogSeo')

      allow(BlogSeo).to receive(:all).and_return(blog_seo)
      allow(blog_seo).to receive(:map).and_return([])
    end

    context "call metatags in first time" do
      it "hits database in the first time" do
        expect(BlogSeo).to receive(:all).once
        BlogSeo.metatags
      end
    end

    context "call metatags in first time" do
      it "hits database in the first time" do
        BlogSeo.metatags
        expect(BlogSeo).not_to receive(:all)
        BlogSeo.metatags
      end
    end
  end

  describe "#after_initialize" do
    before do
      allow(BlogSetting).to receive(:blog_title).and_return("Blog Title")
    end

    it "calls initialize" do
      blog_seo = BlogSeo.new
      expect(blog_seo.value).not_to eq(nil)
      expect(blog_seo.value).to eq("<meta property='og:title' content='#{BlogSetting.blog_title}' />" )
    end

    it "calls initialize" do
      blog_seo = BlogSeo.new(value: 'blogseo')
      expect(blog_seo.value).to eq('blogseo')
    end
  end

  describe "#clear_metatags" do
    let!(:blog_seo) { create(:blog_seo) }

    it "calls clear_metatags after save" do
      blog_seo.value = "Updated Value"
      expect(blog_seo).to receive(:clear_metatags)
      blog_seo.save!
    end
  end
end

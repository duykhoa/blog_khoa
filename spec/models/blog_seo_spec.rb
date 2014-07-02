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
end

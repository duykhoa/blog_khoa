require 'rails_helper'

describe Article do

  describe "#article_url_slug" do
    let!(:article) { build(:article, title: 'đây là test data') }

    it 'returns an url with title' do
      expect(article.article_url_slug).to eq('day-la-test-data')
    end
  end

  describe "#related_articles" do
    let!(:articles) { create_list(:article, 4) }

    it "returns a article array, not include the current_article" do
      expect(articles.first.related_articles.count).to eq(3)
      expect(articles.first.related_articles).not_to include(articles.first)
    end
  end

  describe ".search" do
    def index_of(search_result, article)
      search_result.to_a.index { |item| item.id == article.id.to_s }
    end

    context "search by query do" do
      let!(:marketing_article) { create(:article, title: "Marketing Blog 1")}
      let!(:other_articles) { create_list(:article, 2)}
      let!(:search_params) { {query: 'marketing', page: 1} }
      before(:each) { Article.tire.index.refresh }

      it 'returns articles matched the query in title' do
        search_result = Article.search(:all, search_params)
        expect(search_result.count).to eq(1)
      end
    end

    context "search without query params" do
      let!(:articles) { create_list(:article, 2)}
      let(:search_params) { {} }

      before(:each) { Article.tire.index.refresh }

      it "returns all articles" do
        expect(Article.search(search_params).count).to eq(2)
      end
    end
  end

  describe "#create_or_update_with_commit_type" do
    let(:article) { build(:article) }

    context "save as draft" do
      before { article.create_or_update_with_commit_type(Article::DRAFT) }

      it "saves new article as draft" do
        expect(article.publish?).to be false
      end
    end

    context "publish new article" do
      before { article.create_or_update_with_commit_type(:no_draft) }

      it "publishes article" do
        expect(article.publish?).to be true
      end
    end
  end

  describe "#related_articles" do
    let!(:article) { create(:article) }
    let!(:other_articles) { create_list(:article, 3) }

    before { Article.tire.index.refresh }

    it "returns a list of related articles" do
      expect(article.related_articles).not_to include(:article)
    end
  end
end

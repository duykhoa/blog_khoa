require 'rails_helper'

describe Article do
  it { should belong_to(:category) }
  #it { should validate_presence_of(:category) }
  #it { should validate_presence_of(:title) }

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
        search_result = Article.search(search_params)
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

    context 'search by catetory' do
      let!(:marketing_story_category) { create(:category, name: "marketingblog") }
      let!(:marketing_story_article) { create(:article, category: marketing_story_category, title: "Blog Article") }
      let!(:another_article) { create(:article, title: "Blog Article") }

      let!(:search_params_with_category) { {query: 'article', page: 1, category_name: marketing_story_category.name} }
      let!(:search_params1) { {query: 'article', page: 1} }
      let!(:search_params2) { {query: 'article', page: 1, category_name: ''} }
      before(:each) { Article.tire.index.refresh }

      it "return just 1 article for marketing category" do
        result = Article.search(search_params_with_category)
        expect(result.count).to eq(1)
      end

      it "return just all article" do
        result1 = Article.search(search_params1)
        expect(result1.count).to eq(2)

        result2 = Article.search(search_params2)
        expect(result2.count).to eq(2)
      end
    end
  end
end

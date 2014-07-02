require 'rails_helper'

describe Article do
  it { should belong_to(:category) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:title) }

  describe "#article_url" do
    let!(:article) { build(:article) }

    it 'returns an url with title' do
      expect(article.article_url).to eq([:title])
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

    context 'search by catetory' do
      let!(:marketing_story_category) { create(:category, name: "marketing") }
      let!(:marketing_story_article) { create(:article, category: marketing_story_category, title: "Blog Article") }
      let!(:another_article) { create(:article, title: "Blog Article") }
      let!(:search_params) { {query: 'article', page: 1, category_name: marketing_story_category.name} }
      before(:each) { Article.tire.index.refresh }

      it "return just 1 article for marketing category" do
        result = Article.search(search_params)
        expect(result.count).to eq(1)
      end

      # TODO: category have more than 1 word, search fail
    end
  end
end

require 'spec_helper'

describe ArticlesController do
  let!(:articles) { create_list(:article, 8) }
  before { Article.tire.index.refresh }

  describe "#set_article" do
    it "calls set_article method when visit to show action" do
      expect(controller).to receive(:set_article)
      get :show, id: 1
    end

    it "does not call set_article method when visit another action" do
      expect(controller).not_to receive(:set_article)
      get :index
    end
  end

  describe "#category_index" do
    it "returns a list of article" do
      get :category_index, category_name: ''
      expect(assigns(:articles).count).to eq(8)
    end
  end

  describe "#index" do
    it "returns a list of article" do
      get :index
      expect(assigns(:articles).count).to eq(8)
    end
  end

  describe "#search" do
    let(:search_params) { {query: '-'} }
    it "redirect_to to search_seo_friendly_path" do
      get :search
      expect(response).to redirect_to(search_seo_friendly_path(search_params[:query], page: 1))
    end
  end
end

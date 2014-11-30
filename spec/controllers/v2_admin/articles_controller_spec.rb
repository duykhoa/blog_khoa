require 'rails_helper'

describe V2Admin::ArticlesController, :type => :controller do
  let!(:user) { create :user }

  before do
    sign_in user
  end

  describe "GET index" do
    let!(:articles) { create_list(:article, 10) }
    before { Article.tire.index.refresh }

    it "assigns @articles" do
      get :index
      expect(assigns(:articles).count).to eq(10)
    end
  end

  describe "GET new" do
    it "assigns @article" do
      get :new
      expect(assigns(:article)).to be_a_new(Article)
    end
  end

  describe "GET edit" do
    let(:article) { create(:article) }

    it "assigns @article" do
      get :edit, id: article.slug
      expect(assigns(:article)).to eq(article)
    end
  end

  describe "POST create" do
    let(:param) do
      {
        title: 'Title',
        content: 'Content'
      }
    end

    it "creates a new article" do
      post :create, article: param
      expect(response).to redirect_to(:v2_admin_articles)
    end
  end

  describe "PATCH update" do
    let(:article) { create(:article) }
    let(:param) do
      {
        title: 'Title',
        content: 'Content'
      }
    end

    it "updates an article" do
      patch :update, { id: article.id, article: param }
      expect(response).to redirect_to(:v2_admin_articles)
    end
  end

  describe "DELETE destroy" do
    let(:article) { create(:article) }

    it "assigns @article" do
      delete :destroy, id: article.slug
      expect(assigns(:article)).to eq(article)
      expect(response).to redirect_to(:v2_admin_articles)
    end
  end

end

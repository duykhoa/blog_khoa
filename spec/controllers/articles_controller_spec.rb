require 'spec_helper'

describe ArticlesController do
  let!(:articles) { create_list(:article, 8) }
  let!(:admin_user) { create(:user) }

  before do
    Article.tire.index.refresh
    sign_in admin_user
  end

  describe "#set_article" do
    it "calls set_article method when visit to show action" do
      allow(controller).to receive(:set_comments).and_return(true)

      expect(controller).to receive(:set_article)
      get :show, id: 1
    end

    it "does not call set_article method when visit another action" do
      expect(controller).not_to receive(:set_article)
      get :index
    end
  end

  describe "#index" do
    it "returns a list of article" do
      get :index
      expect(assigns(:articles).count).to eq(8)
    end
  end
end

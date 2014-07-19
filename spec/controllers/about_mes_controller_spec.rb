require 'rails_helper'

describe AboutMesController do
  let!(:about_me) { create(:about_me) }
  describe "#index" do
    it "gets first about me and assigns to @about_me" do
      get :index
      expect(assigns(:about_me)).to eq(about_me)
    end
  end
end

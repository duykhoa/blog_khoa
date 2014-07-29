require 'rails_helper'

RSpec.describe ErrorsController, :type => :controller do

  describe "GET 'error_404'" do
    it "returns http success" do
      get 'error_404'
      expect(response).to be_success
    end
  end

  describe "GET 'error_500'" do
    it "returns http success" do
      get 'error_500'
      expect(response).to be_success
    end
  end
end

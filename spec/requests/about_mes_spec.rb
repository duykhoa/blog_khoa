require 'rails_helper'

RSpec.describe "AboutMes", :type => :request do
  describe "GET /about_mes" do
    it "works! (now write some real specs)" do
      get about_mes_path
      expect(response.status).to be(200)
    end
  end
end

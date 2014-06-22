require "rails_helper"

RSpec.describe AboutMesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/about_mes").to route_to("about_mes#index")
    end

    it "routes to #new" do
      expect(:get => "/about_mes/new").to route_to("about_mes#new")
    end

    it "routes to #show" do
      expect(:get => "/about_mes/1").to route_to("about_mes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/about_mes/1/edit").to route_to("about_mes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/about_mes").to route_to("about_mes#create")
    end

    it "routes to #update" do
      expect(:put => "/about_mes/1").to route_to("about_mes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/about_mes/1").to route_to("about_mes#destroy", :id => "1")
    end

  end
end

require "rails_helper"

RSpec.describe TrailersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/trailers").to route_to("trailers#index")
    end


    it "routes to #show" do
      expect(:get => "/trailers/1").to route_to("trailers#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/trailers").to route_to("trailers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/trailers/1").to route_to("trailers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/trailers/1").to route_to("trailers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/trailers/1").to route_to("trailers#destroy", :id => "1")
    end

  end
end

require "rails_helper"

RSpec.describe YoutubesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/youtubes").to route_to("youtubes#index")
    end

    it "routes to #new" do
      expect(:get => "/youtubes/new").to route_to("youtubes#new")
    end

    it "routes to #show" do
      expect(:get => "/youtubes/1").to route_to("youtubes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/youtubes/1/edit").to route_to("youtubes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/youtubes").to route_to("youtubes#create")
    end

    it "routes to #update" do
      expect(:put => "/youtubes/1").to route_to("youtubes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/youtubes/1").to route_to("youtubes#destroy", :id => "1")
    end

  end
end

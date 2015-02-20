require "rails_helper"

RSpec.describe MoviesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/movies").to route_to("movies#index")
    end

    it "routes to #new" do
      expect(:get => "/movies/new").not_to be_routable
    end

    it "routes to #show" do
      expect(:get => "/movies/1").not_to be_routable
    end

    it "routes to #edit" do
      expect(:get => "/movies/1/edit").not_to be_routable
    end

    it "routes to #create" do
      expect(:put => "/movies").not_to be_routable
    end

    it "routes to #update" do
      expect(:put => "/movies/1").not_to be_routable
    end

    it "routes to #destroy" do
      expect(:delete => "/movies/1").not_to be_routable
    end

    it "routes to #streaming" do
      expect(:get => "/movies/streaming").to route_to("movies#streaming")
    end

    it "routes to #streamnico" do
      expect(:get => "/movies/streamnico").to route_to("movies#streamnico")
    end

    it "routes to #show_niconico" do
      expect(:get => "/movies/show_niconico/1").to route_to("movies#show_niconico", id: "1")
    end

    it "routes to #show_youtube" do
      expect(:get => "/movies/show_youtube/1").to route_to("movies#show_youtube", id: "1")
    end

  end
end

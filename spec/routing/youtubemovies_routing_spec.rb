require "spec_helper"

describe YoutubemoviesController do
  describe "routing" do

    it "routes to #index" do
      get("/youtubemovies").should route_to("youtubemovies#index")
    end

    it "routes to #new" do
      get("/youtubemovies/new").should route_to("youtubemovies#new")
    end

    it "routes to #show" do
      get("/youtubemovies/1").should route_to("youtubemovies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/youtubemovies/1/edit").should route_to("youtubemovies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/youtubemovies").should route_to("youtubemovies#create")
    end

    it "routes to #update" do
      put("/youtubemovies/1").should route_to("youtubemovies#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/youtubemovies/1").should route_to("youtubemovies#destroy", :id => "1")
    end

  end
end

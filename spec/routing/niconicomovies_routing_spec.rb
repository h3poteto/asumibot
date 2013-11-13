require "spec_helper"

describe NiconicomoviesController do
  describe "routing" do

    it "routes to #index" do
      get("/niconicomovies").should route_to("niconicomovies#index")
    end

    it "routes to #new" do
      get("/niconicomovies/new").should route_to("niconicomovies#new")
    end

    it "routes to #show" do
      get("/niconicomovies/1").should route_to("niconicomovies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/niconicomovies/1/edit").should route_to("niconicomovies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/niconicomovies").should route_to("niconicomovies#create")
    end

    it "routes to #update" do
      put("/niconicomovies/1").should route_to("niconicomovies#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/niconicomovies/1").should route_to("niconicomovies#destroy", :id => "1")
    end

  end
end

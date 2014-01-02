require "spec_helper"

describe RecommendsController do
  describe "routing" do

    it "routes to #index" do
      get("/recommends").should route_to("recommends#index")
    end

    it "routes to #new" do
      get("/recommends/new").should route_to("recommends#new")
    end

    it "routes to #show" do
      get("/recommends/1").should route_to("recommends#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recommends/1/edit").should route_to("recommends#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recommends").should route_to("recommends#create")
    end

    it "routes to #update" do
      put("/recommends/1").should route_to("recommends#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recommends/1").should route_to("recommends#destroy", :id => "1")
    end

  end
end

require "spec_helper"

describe SerifsController do
  describe "routing" do

    it "routes to #index" do
      get("/serifs").should route_to("serifs#index")
    end

    it "routes to #new" do
      get("/serifs/new").should route_to("serifs#new")
    end

    it "routes to #show" do
      get("/serifs/1").should route_to("serifs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/serifs/1/edit").should route_to("serifs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/serifs").should route_to("serifs#create")
    end

    it "routes to #update" do
      put("/serifs/1").should route_to("serifs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/serifs/1").should route_to("serifs#destroy", :id => "1")
    end

  end
end

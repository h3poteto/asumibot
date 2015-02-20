require "rails_helper"

RSpec.describe Admins::NiconicomoviesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admins/niconicomovies").to route_to("admins/niconicomovies#index")
    end

    it "routes to #new" do
      expect(:get => "/admins/niconicomovies/new").not_to be_routable
    end

    it "routes to #show" do
      expect(:get => "/admins/niconicomovies/1").not_to be_routable
    end

    it "routes to #edit" do
      expect(:get => "/admins/niconicomovies/1/edit").to route_to("admins/niconicomovies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admins/niconicomovies").not_to be_routable
    end

    it "routes to #update" do
      expect(:put => "/admins/niconicomovies/1").to route_to("admins/niconicomovies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admins/niconicomovies/1").not_to be_routable
    end

  end
end

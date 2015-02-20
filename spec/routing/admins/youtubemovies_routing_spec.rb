require "rails_helper"

RSpec.describe Admins::YoutubemoviesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admins/youtubemovies").to route_to("admins/youtubemovies#index")
    end

    it "routes to #new" do
      expect(:get => "/admins/youtubemovies/new").not_to be_routable
    end

    it "routes to #show" do
      expect(:get => "/admins/youtubemovies/1").not_to be_routable
    end

    it "routes to #edit" do
      expect(:get => "/admins/youtubemovies/1/edit").to route_to("admins/youtubemovies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admins/youtubemovies").not_to be_routable
    end

    it "routes to #update" do
      expect(:put => "/admins/youtubemovies/1").to route_to("admins/youtubemovies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admins/youtubemovies/1").not_to be_routable
    end

  end
end

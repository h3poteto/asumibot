require "rails_helper"

RSpec.describe RecommendsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/recommends").to route_to("recommends#index")
    end

    it "routes to #new" do
      expect(:get => "/recommends/new").not_to be_routable
    end

    it "routes to #show" do
      expect(:get => "/recommends/1").not_to be_routable
    end

    it "routes to #edit" do
      expect(:get => "/recommends/1/edit").not_to be_routable
    end

    it "routes to #create" do
      expect(:post => "/recommends").not_to be_routable
    end

    it "routes to #update" do
      expect(:put => "/recommends/1").not_to be_routable
    end

    it "routes to #destroy" do
      expect(:delete => "/recommends/1").not_to be_routable
    end

  end
end

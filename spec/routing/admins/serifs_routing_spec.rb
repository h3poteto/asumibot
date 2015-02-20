require "rails_helper"

RSpec.describe Admins::SerifsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admins/serifs").to route_to("admins/serifs#index")
    end

    it "routes to #new" do
      expect(:get => "/admins/serifs/new").to route_to("admins/serifs#new")
    end

    it "routes to #show" do
      expect(:get => "/admins/serifs/1").not_to be_routable
    end

    it "routes to #edit" do
      expect(:get => "/admins/serifs/1/edit").to route_to("admins/serifs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admins/serifs").to route_to("admins/serifs#create")
    end

    it "routes to #update" do
      expect(:put => "/admins/serifs/1").to route_to("admins/serifs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admins/serifs/1").to route_to("admins/serifs#destroy", :id => "1")
    end

  end
end

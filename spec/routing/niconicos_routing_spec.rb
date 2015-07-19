require "rails_helper"

RSpec.describe NiconicosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/niconicos").to route_to("niconicos#index", format: :json)
    end

    it "routes to #today" do
      expect(:get => "/niconicos/today").to route_to("niconicos#today", format: :json)
    end
  end
end

require "rails_helper"

RSpec.describe YoutubesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/youtubes").to route_to("youtubes#index", format: :json)
    end

    it "routes to #today" do
      expect(:get => "/youtubes/today").to route_to("youtubes#today", format: :json)
    end
  end
end

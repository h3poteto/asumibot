require 'spec_helper'

describe "Niconicomovies" do
  describe "GET /niconicomovies" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get niconicomovies_path
      response.status.should be(200)
    end
  end
end

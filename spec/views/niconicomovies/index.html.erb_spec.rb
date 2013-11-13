require 'spec_helper'

describe "niconicomovies/index" do
  before(:each) do
    assign(:niconicomovies, [
      stub_model(Niconicomovie),
      stub_model(Niconicomovie)
    ])
  end

  it "renders a list of niconicomovies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end

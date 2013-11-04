require 'spec_helper'

describe "youtubemovies/index" do
  before(:each) do
    assign(:youtubemovies, [
      stub_model(Youtubemovie),
      stub_model(Youtubemovie)
    ])
  end

  it "renders a list of youtubemovies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end

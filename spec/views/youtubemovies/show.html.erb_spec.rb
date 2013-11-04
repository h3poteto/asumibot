require 'spec_helper'

describe "youtubemovies/show" do
  before(:each) do
    @youtubemovie = assign(:youtubemovie, stub_model(Youtubemovie))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end

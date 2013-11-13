require 'spec_helper'

describe "niconicomovies/show" do
  before(:each) do
    @niconicomovie = assign(:niconicomovie, stub_model(Niconicomovie))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end

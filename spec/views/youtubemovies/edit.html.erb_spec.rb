require 'spec_helper'

describe "youtubemovies/edit" do
  before(:each) do
    @youtubemovie = assign(:youtubemovie, stub_model(Youtubemovie))
  end

  it "renders the edit youtubemovie form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", youtubemovie_path(@youtubemovie), "post" do
    end
  end
end

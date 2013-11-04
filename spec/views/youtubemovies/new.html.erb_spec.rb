require 'spec_helper'

describe "youtubemovies/new" do
  before(:each) do
    assign(:youtubemovie, stub_model(Youtubemovie).as_new_record)
  end

  it "renders new youtubemovie form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", youtubemovies_path, "post" do
    end
  end
end

require 'spec_helper'

describe "niconicomovies/new" do
  before(:each) do
    assign(:niconicomovie, stub_model(Niconicomovie).as_new_record)
  end

  it "renders new niconicomovie form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", niconicomovies_path, "post" do
    end
  end
end

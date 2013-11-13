require 'spec_helper'

describe "niconicomovies/edit" do
  before(:each) do
    @niconicomovie = assign(:niconicomovie, stub_model(Niconicomovie))
  end

  it "renders the edit niconicomovie form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", niconicomovie_path(@niconicomovie), "post" do
    end
  end
end

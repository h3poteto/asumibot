require 'spec_helper'

describe "serifs/edit" do
  before(:each) do
    @serif = assign(:serif, stub_model(Serif))
  end

  it "renders the edit serif form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", serif_path(@serif), "post" do
    end
  end
end

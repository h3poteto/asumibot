require 'spec_helper'

describe "serifs/show" do
  before(:each) do
    @serif = assign(:serif, stub_model(Serif))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end

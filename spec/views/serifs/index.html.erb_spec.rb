require 'spec_helper'

describe "serifs/index" do
  before(:each) do
    assign(:serifs, [
      stub_model(Serif),
      stub_model(Serif)
    ])
  end

  it "renders a list of serifs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end

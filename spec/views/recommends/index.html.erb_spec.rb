require 'spec_helper'

describe "recommends/index" do
  before(:each) do
    assign(:recommends, [
      stub_model(Recommend),
      stub_model(Recommend)
    ])
  end

  it "renders a list of recommends" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end

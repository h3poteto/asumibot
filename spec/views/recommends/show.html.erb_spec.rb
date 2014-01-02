require 'spec_helper'

describe "recommends/show" do
  before(:each) do
    @recommend = assign(:recommend, stub_model(Recommend))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end

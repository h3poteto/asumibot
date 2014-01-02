require 'spec_helper'

describe "recommends/edit" do
  before(:each) do
    @recommend = assign(:recommend, stub_model(Recommend))
  end

  it "renders the edit recommend form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", recommend_path(@recommend), "post" do
    end
  end
end

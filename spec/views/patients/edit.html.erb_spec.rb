require 'spec_helper'

describe "patients/edit" do
  before(:each) do
    @patient = assign(:patient, stub_model(Patient,
      :name => "MyString",
      :level => 1
    ))
  end

  it "renders the edit patient form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", patient_path(@patient), "post" do
      assert_select "input#patient_name[name=?]", "patient[name]"
      assert_select "input#patient_level[name=?]", "patient[level]"
    end
  end
end

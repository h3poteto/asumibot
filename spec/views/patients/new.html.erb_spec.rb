require 'spec_helper'

describe "patients/new" do
  before(:each) do
    assign(:patient, stub_model(Patient,
      :name => "MyString",
      :level => 1
    ).as_new_record)
  end

  it "renders new patient form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", patients_path, "post" do
      assert_select "input#patient_name[name=?]", "patient[name]"
      assert_select "input#patient_level[name=?]", "patient[level]"
    end
  end
end

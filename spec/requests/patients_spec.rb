require 'rails_helper'

RSpec.describe "Patients", type: :request do
  before(:each) do
    @patient = create(:patient)
  end
  describe "GET /patients" do
    it "works!" do
      get patients_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /patient" do
    it "works!" do
      get patient_path(@patient)
      expect(response).to have_http_status(200)
    end
  end
end

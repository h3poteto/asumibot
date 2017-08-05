require 'rails_helper'

RSpec.describe "Patients", type: :request do
  let(:patient) { create(:patient) }
  before(:each) do
    patient
  end
  describe "GET /patients" do
    it "works!" do
      get patients_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /patient/:id" do
    it "works!" do
      get patient_path(patient)
      expect(response).to have_http_status(200)
    end
  end
end

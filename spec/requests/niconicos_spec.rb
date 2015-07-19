require 'rails_helper'

RSpec.describe "Niconicos", type: :request do
  describe "GET /niconicos" do
    let!(:niconico) { create(:niconico_movie) }
    before(:each) do
      get niconicos_path
    end
    it "works! (now write some real specs)" do
      expect(response).to have_http_status(200)
    end
    it do
      expect(response.body).to be_json_eql(niconico.url.to_json).at_path("url")
    end
  end

  describe "GET /niconicos/today" do
    let!(:niconico) { create(:today_niconico) }
    before(:each) do
      get today_niconicos_path
    end
    it do
      expect(response).to have_http_status(200)
    end
    it do
      expect(response.body).to be_json_eql(niconico.url.to_json).at_path("url")
    end
  end
end

require 'rails_helper'

RSpec.describe "Youtubes", type: :request do
  describe "GET /youtubes" do
    let!(:youtube) { create(:youtube_movie) }
    before(:each) do
      get youtubes_path
    end
    it "works! (now write some real specs)" do
      expect(response).to have_http_status(200)
    end
    it do
      expect(response.body).to be_json_eql(youtube.url.to_json).at_path("url")
    end
  end

  describe "GET /youtubes/today" do
    let!(:youtube) { create(:today_youtube) }
    before(:each) do
      get today_youtubes_path
    end
    it do
      expect(response).to have_http_status(200)
    end
    it do
      expect(response.body).to be_json_eql(youtube.url.to_json).at_path("url")
    end
  end
end

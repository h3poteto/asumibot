require 'rails_helper'

RSpec.describe "Youtubes", type: :request do
  describe "GET /youtubes" do
    it "works! (now write some real specs)" do
      get youtubes_path
      expect(response).to have_http_status(200)
    end
  end
end

require 'rails_helper'

RSpec.describe "Admins::Niconicomovies", type: :request do
  include Rack::Test::Methods

  before(:each) do
    @admin = create(:admin)
    login @admin
    @params = { niconico_movie: attributes_for(:niconico_movie)}
    @niconico_movie = create(:niconico_movie)
  end

  describe "GET /admins/niconicomovies" do
    it "works!" do
      get admins_niconicomovies_path
      expect(last_response.status).to eq(200)
    end
  end

  describe "GET /admins/niconicomovies/edit" do
    it "works!" do
      get edit_admins_niconicomovie_path(@niconico_movie)
      expect(last_response.status).to eq(200)
    end
  end

  describe "PUT /admins/niconicomovies/update" do
    it "works!" do
      put admins_niconicomovie_path(@niconico_movie), @params
      expect(last_response.status).to eq(302)
      expect(last_response.errors).to eq("")
    end
  end
end

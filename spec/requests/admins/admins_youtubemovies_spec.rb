require 'rails_helper'

RSpec.describe "Admins::Youtubemovies", type: :request do
  before(:each) do
    @admin = create(:admin)
    login @admin
    @params = { youtube_movie: attributes_for(:youtube_movie) }
    @youtube_movie = create(:youtube_movie)
  end

  describe "GET /admins/youtubemovies" do
    it "works!" do
      get admins_youtubemovies_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /admins/youtubemovies/edit" do
    it "works" do
      get edit_admins_youtubemovie_path(@youtube_movie)
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT /admins/youtubemovies/update" do
    it "works!" do
      put admins_youtubemovie_path(@youtube_movie), @params
      expect(response).to have_http_status(200)
    end
  end
end

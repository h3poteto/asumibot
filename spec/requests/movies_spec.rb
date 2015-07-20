require 'rails_helper'

RSpec.describe "Movies", type: :request do
  before(:each) do
    @youtube = create(:youtube_movie)
    @niconico = create(:niconico_movie)
  end
  describe "GET /movies" do
    context "htmlのとき" do
      it "works!" do
        get movies_path
        expect(response).to have_http_status(200)
      end
    end
    context "jsonのとき" do
      it do
        get(movies_path, format: :json)
        expect(response).to have_http_status(200)
      end
      it do
        get(movies_path, format: :json)
        expect([@youtube.url, @niconico.url]).to include(JSON.parse(response.body)["url"])
      end
    end
  end

  describe "GET /movies/show_youtube" do
    it "works!" do
      get youtube_path(@youtube)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /movies/show_niconico" do
    it "works!" do
      get niconico_path(@niconico)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /movies/streaming" do
    it "works!" do
      get streaming_movies_path
      expect(response).to have_http_status(200)
    end
  end
end

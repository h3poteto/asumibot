require 'rails_helper'

RSpec.describe YoutubeFavUser, type: :model do
  describe 'when migrate', :migration do
    # association
    it { should belong_to(:fav_youtube) }
    it { should belong_to(:fav_user) }

    # have db column
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:youtube_movie_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'fav_count' do
    before(:each) do
      @movie = create(:youtube_movie)
      for i in 0..9 do
        youtube_fav = build(:youtube_fav_each_user)
        youtube_fav.youtube_movie_id = @movie.id
        youtube_fav.save
      end
    end
    it "have 10 count" do
      expect(YoutubeFavUser.fav_count(@movie.id)).to eq(10)
    end
  end

  describe 'recent fav order' do
    before(:each) do
      @movies = []
      for i in 1..10 do
        movie = create(:youtube_movie)
        @movies.push([movie, i])
        for j in 1..i do
          youtube_fav = build(:youtube_fav_each_user)
          youtube_fav.youtube_movie_id = movie.id
          youtube_fav.save
        end
      end
    end
    it "should light order" do
      allow(Time).to receive(:current).and_return(Time.current + 1.hours)
      recent = YoutubeFavUser.recent
      expect(recent).to eq(@movies.reverse)
    end
  end
end

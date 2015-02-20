require 'rails_helper'

RSpec.describe NiconicoFavUser, type: :model do
  describe 'when migrate', :migration do
    # association
    it { should belong_to(:fav_niconico) }
    it { should belong_to(:fav_user) }

    # have db column
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:niconico_movie_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'fav_count' do
    before(:each) do
      @movie = create(:niconico_movie)
      for i in 0..9 do
        niconico_fav = build(:niconico_fav_each_user)
        niconico_fav.niconico_movie_id = @movie.id
        niconico_fav.save
      end
    end
    it "have 10 count" do
      expect(NiconicoFavUser.fav_count(@movie.id)).to eq(10)
    end
  end

  describe 'recent fav order' do
    before(:each) do
      @movies = []
      for i in 1..10 do
        movie = create(:niconico_movie)
        @movies.push([movie, i])
        for j in 1..i do
          niconico_fav = build(:niconico_fav_each_user)
          niconico_fav.niconico_movie_id = movie.id
          niconico_fav.save
        end
      end
    end
    it "should light order" do
      allow(Time).to receive(:current).and_return(Time.current + 1.hours)
      recent = NiconicoFavUser.recent
      expect(recent).to eq(@movies.reverse)
    end
  end
end

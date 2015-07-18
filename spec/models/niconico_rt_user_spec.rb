require 'rails_helper'

RSpec.describe NiconicoRtUser, type: :model do
  describe 'when migrate', :migration do
    # association
    it { should belong_to(:rt_niconico) }
    it { should belong_to(:rt_user) }

    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:niconico_movie_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'retweet_count' do
    let(:user) { create(:user) }
    let(:movie) { create(:niconico_movie) }
    before(:each) do
      for i in 0..9 do
        create(:niconico_rt_user, rt_user: user, rt_niconico: movie)
      end
    end
    it "have 10 count" do
      expect(NiconicoRtUser.rt_count(movie.id)).to eq(10)
    end
  end

  describe 'recent retweet order' do
    let(:user) { create(:user) }
    before(:each) do
      @movies = []
      for i in 1..10 do
        movie = create(:niconico_movie)
        @movies.push([movie, i])
        for j in 1..i do
          create(:niconico_rt_user, rt_user: user, rt_niconico: movie)
        end
      end
    end
    it "should light order" do
      allow(Time).to receive(:current).and_return(Time.current + 1.hours)
      recent = NiconicoRtUser.recent
      expect(recent).to eq(@movies.reverse)
    end
  end
end

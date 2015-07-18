require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'when migrate', :migration do
    # association
    it { should have_many(:youtube_fav_users) }
    it { should have_many(:fav_youtubes).through(:youtube_fav_users) }
    it { should have_many(:niconico_fav_users) }
    it { should have_many(:fav_niconicos).through(:niconico_fav_users) }
    it { should have_many(:youtube_rt_users) }
    it { should have_many(:rt_youtubes).through(:youtube_rt_users) }
    it { should have_many(:niconico_rt_users) }
    it { should have_many(:rt_niconicos).through(:niconico_rt_users) }

    # have db column
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:twitter_id).of_type(:integer) }
    it { should have_db_column(:screen_name).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'when validate', :validation do
    it { should validate_uniqueness_of(:twitter_id) }
  end

  describe '.find_or_create' do
    let(:screen_name) { Faker::Internet.user_name }
    let(:twitter_id) { Faker::Number.number(5).to_i }
    context 'すでにユーザが登録されているとき' do
      let!(:user) { create(:user, twitter_id: twitter_id, screen_name: screen_name) }
      it do
        expect{ User.find_or_create(screen_name, twitter_id) }.not_to change{ User.count }.from(1)
      end
      it do
        expect(User.find_or_create(screen_name, twitter_id)).to eq(user)
      end
    end
    context 'ユーザが登録されていないとき' do
      it do
        expect(User.find_or_create(screen_name, twitter_id).twitter_id).to eq(twitter_id)
      end
    end
  end
end

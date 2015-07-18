require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'when migrate', :migration do
    # association
    it { should have_many(:asumi_tweets) }
    it { should have_many(:asumi_levels) }

    # have db column
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:twitter_id).of_type(:integer) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:nickname).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:icon).of_type(:string) }
    it { should have_db_column(:all_tweet).of_type(:integer) }
    it { should have_db_column(:friend).of_type(:integer) }
    it { should have_db_column(:follower).of_type(:integer) }
    it { should have_db_column(:level).of_type(:integer) }
    it { should have_db_column(:asumi_count).of_type(:integer) }
    it { should have_db_column(:tweet_count).of_type(:integer) }
    it { should have_db_column(:asumi_word).of_type(:integer) }
    it { should have_db_column(:prev_level).of_type(:integer) }
    it { should have_db_column(:prev_level_tweet).of_type(:integer) }
    it { should have_db_column(:prev_tweet_count).of_type(:integer) }
    it { should have_db_column(:prev_asumi_word).of_type(:integer) }
    it { should have_db_column(:since_id).of_type(:string) }
    it { should have_db_column(:clear).of_type(:boolean).with_options(null: false, default: false) }
    it { should have_db_column(:protect).of_type(:boolean).with_options(null: false) }
    it { should have_db_column(:locked).of_type(:boolean).with_options(null: false, default: false) }
    it { should have_db_column(:disabled).of_type(:boolean).with_options(null: false, default: false) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'when validate', :validation do
    it { should validate_uniqueness_of(:twitter_id) }
    it { should validate_presence_of(:twitter_id) }
  end
end

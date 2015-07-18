require 'rails_helper'

RSpec.describe AsumiTweet, type: :model do
  describe 'when migrate', :migration do
    # association
    it { should belong_to(:patient) }

    # have db column
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:patient_id).of_type(:integer) }
    it { should have_db_column(:tweet).of_type(:string) }
    it { should have_db_column(:tweet_id).of_type(:string) }
    it { should have_db_column(:tweet_time).of_type(:datetime).with_options(null:false) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end
end

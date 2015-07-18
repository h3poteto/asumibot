require 'rails_helper'

RSpec.describe LastData, type: :model do
  describe 'when migrate', :migration do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:category).of_type(:string) }
    it { should have_db_column(:tweet_id).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end
end

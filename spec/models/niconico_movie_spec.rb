require 'rails_helper'

RSpec.describe NiconicoMovie, type: :model do
  describe 'when migrate', :migration do
    # association
    it { should have_many(:niconico_fav_users) }
    it { should have_many(:fav_users) }
    it { should have_many(:niconico_rt_users) }
    it { should have_many(:rt_users) }

    # have db column
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:url).of_type(:string) }
    it { should have_db_column(:description).of_type(:string) }
    it { should have_db_column(:priority).of_type(:boolean) }
    it { should have_db_column(:disabled).of_type(:boolean).with_options(null: false, default: false) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'when validate', :validation do
    it { should validate_uniqueness_of(:url) }
  end
end

require 'rails_helper'

RSpec.describe TodayNiconico, type: :model do
  describe 'when migrate', :migration do
    # have db column
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:url).of_type(:string) }
    it { should have_db_column(:description).of_type(:string) }
    it { should have_db_column(:priority).of_type(:boolean) }
    it { should have_db_column(:used).of_type(:boolean).with_options(null: false, default: false) }
    it { should have_db_column(:disabled).of_type(:boolean).with_options(default: false) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'when validate', :validation do
    it { should validate_uniqueness_of(:url) }
  end
end

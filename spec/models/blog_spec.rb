require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'when migrate', :migration do
    # have db column
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:link).of_type(:string) }
    it { should have_db_column(:used).of_type(:boolean).with_options(default: false) }
    it { should have_db_column(:post_at).of_type(:datetime) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'when validate', :validation do
    it { should validate_uniqueness_of(:link) }
  end
end

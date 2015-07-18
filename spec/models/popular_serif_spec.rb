require 'rails_helper'

RSpec.describe PopularSerif, type: :model do
  describe 'when migrate', :migration do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:word).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end
end

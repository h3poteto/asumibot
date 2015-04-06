require 'rails_helper'

RSpec.describe MonthRanking, type: :model do
  describe 'when migrate', :migration do
    # association
    it { should belong_to(:patient) }

    # have db column
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:patient_id).of_type(:integer) }
    it { should have_db_column(:level).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe 'when create' do
    context 'with valid attributes' do
      subject { build(:month_ranking) }
      it "should create a new instance" do
        expect(subject.save).not_to be_falsey
      end
    end
  end

  describe 'when delete', :delete do
    subject { create(:month_ranking) }
    it "should delete" do
      id = subject.id
      expect(subject.destroy).not_to be_falsey
      expect { MonthRanking.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

end

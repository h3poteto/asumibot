require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'when migrate', :migration do
    # have db column
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:task).of_type(:string) }
    it { should have_db_column(:time).of_type(:datetime) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'when validate', :validation do
    it { should validate_uniqueness_of(:task) }
  end

  describe 'when create' do
    context 'with valid attributes' do
      subject { build(:schedule) }
      it "should create a new instance" do
        expect(subject.save).not_to be_falsey
      end
    end
  end

  describe 'when update' do
    context 'after create' do
      before do
        @attr = attributes_for(:schedule)
        @schedule = create(:schedule)
        @schedule.update_attributes(@attr)
      end
      subject { Schedule.find(@schedule.id) }
      it "should new values" do
        @attr.each do |k,v|
          expect(subject.send(k)).to eq(v) unless k == :time
        end
      end
    end
  end

  describe 'when delete', :delete do
    subject { create(:schedule) }
    it "should delete" do
      id = subject.id
      expect(subject.destroy).not_to be_falsey
      expect { Schedule.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

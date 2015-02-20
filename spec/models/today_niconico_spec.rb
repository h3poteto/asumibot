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

  describe 'when create' do
    context 'with valid attributes' do
      subject { build(:today_niconico) }
      it "should create a new instance" do
        expect(subject.save).not_to be_falsey
      end
    end
  end

  describe 'when update' do
    context 'after create' do
      before do
        @attr = attributes_for(:today_niconico)
        @today_niconico = create(:today_niconico)
        @today_niconico.update_attributes(@attr)
      end
      subject { TodayNiconico.find(@today_niconico.id) }
      it "should new values" do
        @attr.each do |k,v|
          expect(subject.send(k)).to eq(v)
        end
      end
    end
  end

  describe 'when delete', :delete do
    subject { create(:today_niconico) }
    it "should delete" do
      id = subject.id
      expect(subject.destroy).not_to be_falsey
      expect { TodayNiconico.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

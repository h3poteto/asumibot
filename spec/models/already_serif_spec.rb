require 'rails_helper'

RSpec.describe AlreadySerif, type: :model do
  describe 'when migrate', :migration do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:word).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'when create' do
    context 'with valid attributes' do
      subject { build(:already_serif) }
      it "should create a new instance" do
        expect(subject.save).not_to be_falsey
      end
    end
  end

  describe 'when update' do
    context 'after create' do
      before do
        @attr = attributes_for(:already_serif)
        @serif = create(:already_serif)
        @serif.update_attributes(@attr)
      end
      subject { AlreadySerif.find(@serif.id) }
      it "should new values" do
        @attr.each do |k,v|
          expect(subject.send(k)).to eq(v)
        end
      end
    end
  end

  describe 'when delete', :delete do
    subject { create(:already_serif) }
    it "should delete" do
      id = subject.id
      expect(subject.destroy).not_to be_falsey
      expect { AlreadySerif.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

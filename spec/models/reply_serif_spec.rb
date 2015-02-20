require 'rails_helper'

RSpec.describe ReplySerif, type: :model do
  describe 'when migrate', :migration do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:word).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'when create' do
    context 'with valid attributes' do
      subject { build(:reply_serif) }
      it "should create a new instance" do
        expect(subject.save).not_to be_falsey
      end
    end
  end

  describe 'when update' do
    context 'after create' do
      before do
        @attr = attributes_for(:reply_serif)
        @serif = create(:reply_serif)
        @serif.update_attributes(@attr)
      end
      subject { ReplySerif.find(@serif.id) }
      it "should new values" do
        @attr.each do |k,v|
          expect(subject.send(k)).to eq(v)
        end
      end
    end
  end

  describe 'when delete', :delete do
    subject { create(:reply_serif) }
    it "should delete" do
      id = subject.id
      expect(subject.destroy).not_to be_falsey
      expect { ReplySerif.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

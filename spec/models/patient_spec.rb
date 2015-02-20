require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'when migrate', :migration do
    # association
    it { should have_many(:asumi_tweets) }
    it { should have_many(:asumi_levels) }

    # have db column
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:twitter_id).of_type(:integer) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:nickname).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:icon).of_type(:string) }
    it { should have_db_column(:all_tweet).of_type(:integer) }
    it { should have_db_column(:friend).of_type(:integer) }
    it { should have_db_column(:follower).of_type(:integer) }
    it { should have_db_column(:level).of_type(:integer) }
    it { should have_db_column(:asumi_count).of_type(:integer) }
    it { should have_db_column(:tweet_count).of_type(:integer) }
    it { should have_db_column(:asumi_word).of_type(:integer) }
    it { should have_db_column(:prev_level).of_type(:integer) }
    it { should have_db_column(:prev_level_tweet).of_type(:integer) }
    it { should have_db_column(:prev_tweet_count).of_type(:integer) }
    it { should have_db_column(:prev_asumi_word).of_type(:integer) }
    it { should have_db_column(:since_id).of_type(:string) }
    it { should have_db_column(:clear).of_type(:boolean).with_options(null: false, default: false) }
    it { should have_db_column(:protect).of_type(:boolean).with_options(null: false) }
    it { should have_db_column(:locked).of_type(:boolean).with_options(null: false, default: false) }
    it { should have_db_column(:disabled).of_type(:boolean).with_options(null: false, default: false) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'when validate', :validation do
    it { should validate_uniqueness_of(:twitter_id) }
    it { should validate_presence_of(:twitter_id) }
  end

  describe 'when create' do
    context 'with valid attributes' do
      subject { build(:patient) }
      it "should create a new instance" do
        expect(subject.save).not_to be_falsey
      end
    end
  end

  describe 'when update' do
    context 'after create' do
      before do
        @attr = attributes_for(:patient)
        @patient = create(:patient)
        @patient.update_attributes(@attr)
      end
      subject { Patient.find(@patient.id) }
      it "should new values" do
        @attr.each do |k,v|
          case k
          when :twitter_id
            expect(subject.send(k).to_i).to eq(v.to_i)
          when :since_id
            expect(subject.send(k).to_i).to eq(v.to_i)
          else
            expect(subject.send(k)).to eq(v)
          end
        end
      end
    end
  end

  describe 'when delete', :delete do
    subject { create(:patient) }
    it "should delete" do
      id = subject.id
      expect(subject.destroy).not_to be_falsey
      expect { Patient.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

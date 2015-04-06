require 'rails_helper'

RSpec.describe AsumiLevel, type: :model do
  describe 'when migrate', :migration do
    # association
    it { should belong_to(:patient) }

    # have db column
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:patient_id).of_type(:integer) }
    it { should have_db_column(:asumi_count).of_type(:integer) }
    it { should have_db_column(:tweet_count).of_type(:integer) }
    it { should have_db_column(:asumi_word).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end


  describe 'when create' do
    context 'with valid attributes' do
      subject { build(:asumi_level) }
      it "should create a new instance" do
        expect(subject.save).not_to be_falsey
      end
    end
  end

  describe 'when update' do
    context 'after create' do
      before do
        @attr = attributes_for(:asumi_level)
        @asumi_level = create(:asumi_level)
        @asumi_level.update_attributes(@attr)
      end
      subject { AsumiLevel.find(@asumi_level.id) }
      it "should new values" do
        @attr.each do |k,v|
          expect(subject.send(k).to_i).to eq(v.to_i)
        end
      end
    end
  end

  describe 'when delete', :delete do
    subject { create(:asumi_level) }
    it "should delete" do
      id = subject.id
      expect(subject.destroy).not_to be_falsey
      expect { AsumiLevel.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "month ranking order" do
    before(:each) do
      @low_patient = create(:patient)
      @high_patient = create(:patient)
      @normal_patient = create(:patient)
      [0..10].each do |f|
        low_level = build(:low_asumi_level)
        low_level.patient = @low_patient
        low_level.save
        high_level = build(:high_asumi_level)
        high_level.patient = @high_patient
        high_level.save
        normal_level = build(:asumi_level)
        normal_level.patient = @normal_patient
        normal_level.save
      end

      it "should right order" do
        patient_rankings = [@high_patient.id, @normal_patient.id, @low_patient.id]
        month_rankings = MonthRanking.level_order
        expect(month_rankings).to eq(patient_rankings)
      end
    end
  end
end

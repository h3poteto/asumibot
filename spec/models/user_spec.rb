require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'when migrate', :migration do
    # association
    it { should have_many(:youtube_fav_users) }
    it { should have_many(:fav_youtubes).through(:youtube_fav_users) }
    it { should have_many(:niconico_fav_users) }
    it { should have_many(:fav_niconicos).through(:niconico_fav_users) }
    it { should have_many(:youtube_rt_users) }
    it { should have_many(:rt_youtubes).through(:youtube_rt_users) }
    it { should have_many(:niconico_rt_users) }
    it { should have_many(:rt_niconicos).through(:niconico_rt_users) }

    # have db column
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:twitter_id).of_type(:integer) }
    it { should have_db_column(:screen_name).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'when validate', :validation do
    it { should validate_uniqueness_of(:twitter_id) }
  end

  describe 'when create' do
    context 'with valid attributes' do
      subject { build(:user) }
      it "should create a new instance" do
        expect(subject.save).not_to be_falsey
      end
    end
  end

  describe 'when update' do
    context 'after create' do
      before do
        @attr = attributes_for(:user)
        @user = create(:user)
        @user.update_attributes(@attr)
      end
      subject { User.find(@user.id) }
      it "should new values" do
        @attr.each do |k,v|
          case k
          when :twitter_id
            expect(subject.send(k).to_i).to eq(v.to_i)
          else
            expect(subject.send(k)).to eq(v)
          end
        end
      end
    end
  end

  describe 'when delete', :delete do
    subject { create(:user) }
    it "should delete" do
      id = subject.id
      expect(subject.destroy).not_to be_falsey
      expect { User.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

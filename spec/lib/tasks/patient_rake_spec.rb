# -*- coding: utf-8 -*-
require 'rails_helper'

describe 'patient:update' do
  include_context "rake"
  let!(:patient) { create(:patient) }
  it do
    expect{ subject.invoke }.to change{ AsumiLevel.count }.from(0).to(1)
  end
end

describe 'patient:tweet' do
  include_context "rake"
  let!(:patient){ create(:patient) }
  before(:each) do
    allow_any_instance_of(TwitterClient).to receive(:update).and_return(true)
  end
  it do
    expect(subject.invoke).not_to eq(false)
  end
end

describe 'patient:clear' do
  include_context "rake"
  let!(:patient) { create(:patient) }
  it do
    expect{ subject.invoke }.to change{ patient.reload.clear }.from(true).to(false)
  end
end

describe 'patient:add' do
  include_context "rake"
  let(:twitter_user) { TwitterUser.new }
  before(:each) do
    allow_any_instance_of(TwitterClient).to receive(:user).and_return(twitter_user)
  end

  context "フォロワーがpatientに登録されているとき" do
    let!(:patient) { create(:patient) }
    context "patientに登録されているユーザがフォロワー内にいるとき（利用しているとき）" do
      before(:each) do
        allow_any_instance_of(TwitterClient).to receive(:follower_ids).and_return([patient.twitter_id])
      end
      it "patientが有効になること" do
        subject.invoke
        expect(patient.reload.disabled).to eq(false)
      end
    end

    context "patientに登録されているユーザがフォロワー内にいないとき（利用していないとき）" do
      before(:each) do
        allow_any_instance_of(TwitterClient).to receive(:follower_ids).and_return([])
      end
      it "patientが無効になること" do
        subject.invoke
        expect(patient.reload.disabled).to eq(true)
      end
    end
  end

  context "フォロワーがpatientに登録されていないとき" do
    before(:each) do
      allow_any_instance_of(TwitterClient).to receive(:follower_ids).and_return([twitter_user.id])
    end
    it "patientにフォロワーが登録されること" do
      expect{ subject.invoke }.to change{ Patient.count }.from(0).to(1)
    end
    it "フォロワーとpatientが一致していること" do
      subject.invoke
      expect(Patient.first.twitter_id).to eq(twitter_user.id)
    end
  end
end

describe 'patient:change_name' do
  include_context "rake"
  let!(:patient) { create(:patient, twitter_id: twitter_user.id) }
  let(:twitter_user) { TwitterUser.new }
  before(:each) do
    allow_any_instance_of(TwitterClient).to receive(:user).and_return(twitter_user)
  end

  it "名前が書き換わっていること" do
    subject.invoke
    expect(patient.reload.name).to eq(twitter_user.screen_name)
    expect(patient.reload.nickname).to eq(twitter_user.name)
  end
end

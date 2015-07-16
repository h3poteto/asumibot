# -*- coding: utf-8 -*-
require 'rails_helper'


describe 'twitter:normal' do
  include_context "rake"
  before(:each) do
    allow(Twitter::REST::Client).to receive(:new).and_return(true)
    allow_any_instance_of(TwitterClient).to receive(:update).and_return(true)
  end
  describe "#normal" do
    let!(:movie) { create(:niconico_popular) }
    before(:each) do
      create_list(:popular_serif, 10)
    end
    it "usedがついていること" do
      expect{ subject.invoke }.to change{ movie.reload.used }.from(false).to(true)

    end
  end
end

describe "twitter:new" do
  include_context "rake"
  before(:each) do
    allow(Twitter::REST::Client).to receive(:new).and_return(true)
    allow_any_instance_of(TwitterClient).to receive(:update).and_return(true)
    allow_any_instance_of(Movies).to receive(:confirm_db).and_return(true)
  end
  describe "#new" do
    let!(:movie) { create(:today_niconico) }
    before(:each) do
      create_list(:new_serif, 10)
    end
    it "usedがついていること" do
      expect{ subject.invoke }.to change{ movie.reload.used }.from(false).to(true)
    end
  end
end

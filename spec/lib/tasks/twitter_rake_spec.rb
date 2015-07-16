# -*- coding: utf-8 -*-
require 'rails_helper'


describe 'twitter:normal' do
  include_context "rake"
  before(:each) do
    allow(Twitter::REST::Client).to receive(:new).and_return(true)
    allow_any_instance_of(TwitterClient).to receive(:update).and_return(true)
    create_list(:popular_serif, 10)
  end
  let!(:movie) { create(:niconico_popular) }
  it "usedがついていること" do
    expect{ subject.invoke }.to change{ movie.reload.used }.from(false).to(true)
  end
end

describe "twitter:new" do
  include_context "rake"
  before(:each) do
    allow(Twitter::REST::Client).to receive(:new).and_return(true)
    allow_any_instance_of(TwitterClient).to receive(:update).and_return(true)
    allow_any_instance_of(Movies).to receive(:confirm_db).and_return(true)
    create_list(:new_serif, 10)
  end
  let!(:movie) { create(:today_niconico) }
  it "usedがついていること" do
    expect{ subject.invoke }.to change{ movie.reload.used }.from(false).to(true)
  end
end

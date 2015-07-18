# -*- coding: utf-8 -*-
require 'rails_helper'


describe 'checkmovie:recent' do
  include_context "rake"
  let(:youtube_right) { "https://www.youtube.com/watch?v=DVwHCGAr_OE" }
  let(:youtube_cannot) { "https://www.youtube.com/watch?v=S4AJQ-yEmEc" }

  context "動画が存在しないとき" do
    let!(:youtube) { create(:youtube_movie, url: youtube_cannot) }
    before(:each) do
      create(:youtube_rt_user, rt_youtube: youtube)
    end
    it do
      expect{ subject.invoke }.to change{ youtube.reload.disabled }.from(false).to(true)
    end
  end
  context "動画が存在するとき" do
    let!(:youtube) { create(:youtube_movie, url: youtube_right) }
    before(:each) do
      create(:youtube_rt_user, rt_youtube: youtube)
    end
    it do
      expect{ subject.invoke }.not_to change{ youtube.reload.disabled }.from(false)
    end
  end
end

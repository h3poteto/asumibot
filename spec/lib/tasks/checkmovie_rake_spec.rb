# -*- coding: utf-8 -*-
require 'rails_helper'


describe 'checkmovie:recent' do
  include_context "rake"
  let(:youtube_right) { "https://www.youtube.com/watch?v=DVwHCGAr_OE" }
  let(:youtube_cannot) { "https://www.youtube.com/watch?v=S4AJQ-yEmEc" }

  context "動画が存在しないとき" do
    let(:youtube) { create(:youtube_movie, url: youtube_cannot, disabled: false) }
    before(:each) do
      Timecop.travel(1.hours.ago) do
        create(:youtube_rt_user, rt_youtube: youtube)
      end
      allow_any_instance_of(URI::HTTPS).to receive(:read).and_return(
        "<html><head><title>YouTube</title></head><body></body></html>"
      )
    end
    it do
      expect{ subject.invoke }.to change{ youtube.reload.disabled }.from(false).to(true)
    end
  end
  context "動画が存在するとき" do
    let(:youtube) { create(:youtube_movie, url: youtube_right, disabled: false) }
    before(:each) do
      Timecop.travel(1.hours.ago) do
        create(:youtube_rt_user, rt_youtube: youtube)
      end
      allow_any_instance_of(URI::HTTPS).to receive(:read).and_return(
        "<html><head><title>YouTube Asumi</title></head><body></body></html>"
      )
    end
    it do
      expect{ subject.invoke }.not_to change{ youtube.reload.disabled }.from(false)
    end
  end
end

# -*- coding: utf-8 -*-
require 'rails_helper'

describe 'youtube:clear' do
  include_context "rake"
  before(:each) do
    Timecop.travel(2.hours.ago) do
      create_list(:youtube_popular, 3)
      create_list(:today_youtube, 3)
    end
  end
  it do
    expect { subject.invoke }.to change { YoutubePopular.count }.from(3).to(0)
  end
  it do
    expect { subject.invoke }.to change { TodayYoutube.count }.from(3).to(0)
  end
end

describe 'youtube:popular' do
  include_context "rake"
  it do
    expect { subject.invoke }.to change { YoutubePopular.count }.from(0)
  end
end

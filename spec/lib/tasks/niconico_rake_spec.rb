# -*- coding: utf-8 -*-
require 'rails_helper'

describe 'niconico:clear' do
  include_context "rake"
  before(:each) do
    Timecop.travel(2.hours.ago) do
      create_list(:niconico_popular, 3)
      create_list(:today_niconico, 3)
    end
  end
  it do
    expect { subject.invoke }.to change { NiconicoPopular.count }.from(3).to(0)
  end
  it do
    expect { subject.invoke }.to change { TodayNiconico.count }.from(3).to(0)
  end
end

describe 'niconico:popular' do
  include_context "rake"
  it do
    expect { subject.invoke }.to change { NiconicoPopular.count }.from(0)
  end
end

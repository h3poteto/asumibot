# -*- coding: utf-8 -*-
require 'rails_helper'
require 'rails'
require 'rake'


describe 'twitter' do
  before(:all) do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require("twitter", ["#{Rails.root.to_s}/lib/tasks"])
    Rake.application.rake_require("asumistream", ["#{Rails.root.to_s}/lib/tasks"])
    Rake::Task.define_task(:environment)
  end

end

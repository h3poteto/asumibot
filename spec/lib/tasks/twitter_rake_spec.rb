# -*- coding: utf-8 -*-
require 'rails'
require 'rake'


describe 'twitter' do
  # :allでしか呼び出してはダメっぽい。くれぐれも注意
  before(:all) do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require("twitter", ["#{Rails.root.to_s}/lib/tasks"])
    Rake.application.rake_require("asumistream", ["#{Rails.root.to_s}/lib/tasks"])
    Rake::Task.define_task(:environment)
  end

  describe "function test" do
    context "関数テスト"  do
      it "confirm youtube" do
        right_url = "http://www.youtube.com/watch?v=p8l2OENXOao"
        wrong_url = "http://www.youtube.com/watch?v=p8l2OENXOa"
        cannot_url = "http://www.youtube.com/watch?v=S4AJQ-yEmEc"
        other_url = "http://morizyun.github.io/blog/rake-task-rails-rspec-test/"
        expect(confirm_youtube(right_url)).to eq(true)
        expect(confirm_youtube(wrong_url)).to eq(false)
        expect(confirm_youtube(cannot_url)).to eq(false)
        expect(confirm_youtube(other_url)).to eq(false)
      end

      it "confirm niconico" do
        right_url = "http://www.nicovideo.jp/watch/sm19174539"
        wrong_url = "http://www.nicovideo.jp/watch/sm191745392"
        cannot_url = "http://www.nicovideo.jp/watch/sm11779915"
        other_url = "http://morizyun.github.io/blog/rake-task-rails-rspec-test/"
        expect(confirm_niconico(right_url)).to eq true
        expect(confirm_niconico(wrong_url)).to eq false
        expect(confirm_niconico(cannot_url)).to eq false
        expect(confirm_niconico(other_url)).to eq false
      end

      it "confirm db" do
        youtube_right = "http://www.youtube.com/watch?v=p8l2OENXOao"
        youtube_cannot = "http://www.youtube.com/watch?v=S4AJQ-yEmEc"
        niconico_right = "http://www.nicovideo.jp/watch/sm19174539"
        niconico_cannot = "http://www.youtube.com/watch?v=S4AJQ-yEmEc"
        # confirm_db(youtube_right).should eq "youtube"
        # confirm_db(youtube_cannot).should eq false
        # confirm_db(niconico_right).should eq "niconico"
        # confirm_db(niconico_cannot).should eq false
      end
    end
  end
end

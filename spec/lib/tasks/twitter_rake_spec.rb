# -*- coding: utf-8 -*-
require 'rails'
require 'rake'


describe 'twitter' do
  # :allでしか呼び出してはダメっぽい。くれぐれも注意
  before(:all) do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require("twitter", ["/home/akira/projects/asumibot/lib/tasks"])
    Rake::Task.define_task(:environment)
  end

  describe "function test" do
    context "関数テスト"  do
      it "confirm youtube" do
        right_url = "http://www.youtube.com/watch?v=p8l2OENXOao"
        wrong_url = "http://www.youtube.com/watch?v=p8l2OENXOa"
        cannot_url = "http://www.youtube.com/watch?v=S4AJQ-yEmEc"
        other_url = "http://morizyun.github.io/blog/rake-task-rails-rspec-test/"
        confirm_youtube(right_url).should eq true
        confirm_youtube(wrong_url).should eq false
        confirm_youtube(cannot_url).should eq false
        confirm_youtube(other_url).should eq false
      end
      
      it "confirm niconico" do
        right_url = "http://www.nicovideo.jp/watch/sm19174539"
        wrong_url = "http://www.nicovideo.jp/watch/sm191745392"
        cannot_url = "http://www.nicovideo.jp/watch/sm11779915"
        other_url = "http://morizyun.github.io/blog/rake-task-rails-rspec-test/"
        confirm_niconico(right_url).should eq true
        confirm_niconico(wrong_url).should eq false
        confirm_niconico(cannot_url).should eq false
        confirm_niconico(other_url).should eq false
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

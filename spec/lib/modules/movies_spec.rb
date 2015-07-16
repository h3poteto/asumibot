require 'rails_helper'

RSpec.describe Movies do
  let(:test_class) { Struct.new(:test) { include Movies } }
  let(:test_instance) { test_class.new }

  let(:youtube_right) { "https://www.youtube.com/watch?v=DVwHCGAr_OE" }
  let(:youtube_cannot) { "https://www.youtube.com/watch?v=S4AJQ-yEmEc" }
  let(:niconico_right) { "http://www.nicovideo.jp/watch/sm19174539" }
  let(:niconico_cannot) { "http://www.nicovideo.jp/watch/sm11779915" }

  describe "#confirm_youtube" do
    let(:right_url) { youtube_right }
    let(:wrong_url) { "https://www.youtube.com/watch?v=p8l2OENXOa" }
    let(:cannot_url) { youtube_cannot }
    let(:other_url) { "http://morizyun.github.io/blog/rake-task-rails-rspec-test/"    }
    it { expect(test_instance.confirm_youtube(right_url)).to eq(true) }
    it { expect(test_instance.confirm_youtube(wrong_url)).to eq(false) }
    it { expect(test_instance.confirm_youtube(cannot_url)).to eq(false) }
    it { expect(test_instance.confirm_youtube(other_url)).to eq(false) }
  end

  describe "#confirm_niconico" do
    let(:right_url) { niconico_right }
    let(:wrong_url) { "http://www.nicovideo.jp/watch/sm191745392" }
    let(:cannot_url) { niconico_cannot }
    let(:other_url) { "http://morizyun.github.io/blog/rake-task-rails-rspec-test/" }
    it { expect(test_instance.confirm_niconico(right_url)).to eq true }
    it { expect(test_instance.confirm_niconico(wrong_url)).to eq false }
    it { expect(test_instance.confirm_niconico(cannot_url)).to eq false }
    it { expect(test_instance.confirm_niconico(other_url)).to eq false }
  end

  describe "#confirm_db" do
    before(:each) do
      create(:youtube_movie, url: youtube_right)
      create(:youtube_movie, url: youtube_cannot)
      create(:niconico_movie, url: niconico_right)
      create(:niconico_movie, url: niconico_cannot)
    end
    it { expect(test_instance.confirm_db(youtube_right)).to eq "youtube" }
    it { expect(test_instance.confirm_db(youtube_cannot)).to eq false }
    it { expect(test_instance.confirm_db(niconico_right)).to eq "niconico" }
    it { expect(test_instance.confirm_db(niconico_cannot)).to eq false }
  end

end

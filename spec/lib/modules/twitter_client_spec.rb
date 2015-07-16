require 'rails_helper'

RSpec.describe TwitterClient do
  let(:client) { TwitterClient.new }
  before(:each) do
    allow(Twitter::REST::Client).to receive(:new).and_return(true)
    allow_any_instance_of(Twitter::REST::Client).to receive(:update).and_return(true)
  end

  describe "#trim" do
    subject { client.trim(tweet, url) }
    context "本文とURLが140字以内におさまるとき" do
      let(:tweet) { "毎日あすみんを見たい" }
      let(:url) { "http://www.asumi.ch" }
      it "内容が合致すること" do
        expect(subject).to eq("#{tweet} #{url}")
      end
    end
    context "本文だけで140字を超えるとき" do
      let(:tweet) { "プロモーター、紺野やよい役で出演させていただいてます！
昨日オンエアになった二話目からの登場でした♪
モノクロームちゃんとその仲間たちの奮闘がとっても愉快で痛快で時折シュールなこの作品、私も2期から参加させていただけてうれしいです！
共演者の方もみなさまステキすぎて、アフレコも個人的にかなり楽しませていただいてます（笑）。
やよいたんもドジっ子爆走プロモーターとしてがんばりますよー！
応援よろしくお願いします♪" }
      let(:url) { "http://www.asumi.ch" }
      it "URLの長さ25文字を残して足切りされていること" do
        expect(subject.length).to eq(140 - 23 + url.length)
      end
    end

    context "本文とURLを合わせると140字を超えるとき" do
      let(:tweet) { "プロモーター、紺野やよい役で出演させていただいてます！
昨日オンエアになった二話目からの登場でした♪
モノクロームちゃんとその仲間たちの奮闘がとっても愉快で痛快で時折シュールなこの作品、私も2期から参加させていただけてうれしいです！" }
      let(:url) { "https://www.youtube.com/watch?v=VOhlurQ2HII&feature=youtube_gdata_player" }
      it "URLの長さ25文字を残して足切りされていること" do
        expect(subject.length).to eq(140 - 23 + url.length)
      end
    end

    context "本文だけだったとき" do
      let(:tweet) { "プロモーター、紺野やよい役で出演させていただいてます！
昨日オンエアになった二話目からの登場でした♪
モノクロームちゃんとその仲間たちの奮闘がとっても愉快で痛快で時折シュールなこの作品、私も2期から参加させていただけてうれしいです！
共演者の方もみなさまステキすぎて、アフレコも個人的にかなり楽しませていただいてます（笑）。
やよいたんもドジっ子爆走プロモーターとしてがんばりますよー！
応援よろしくお願いします♪" }
      let(:url) {}
      it "140字になること" do
        expect(subject.length).to eq(140)
      end
    end
  end
end

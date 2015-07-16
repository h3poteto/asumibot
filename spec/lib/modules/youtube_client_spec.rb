require 'rails_helper'

RSpec.describe YoutubeClient do
  # CircleCIにもdeveloper keyを設定しないと落ちる
  let(:client) { YoutubeClient.new }

  describe "#search" do
    subject { client.search(opts) }
    context "最新のものを取ってくるとき" do
      let(:opts) {
        {
          maxResults: 50,
          order: 'date',
          type: 'video',
          publishedAfter: Time.current.yesterday.to_datetime.rfc3339
        }
      }
      it "検索結果が帰ってきていること" do
        expect{ subject }.to change{ client.search_result.length }.from(0)
      end
    end

    context "人気のものを取ってくるとき" do
      let(:opts) {
        {
          maxResults: 50,
          order: 'rating',
          type: 'video'
        }
      }
      it "検索結果が50*キーワードの数だけ帰ってくること" do
        expect{ subject }.to change{ client.search_result.length }.from(0).to(150)
      end
    end
  end

  describe "#asumi_check" do
    subject { client.asumi_check(keyword) }
    context "「阿澄」を含むとき" do
      let(:keyword) { "阿澄かわいい" }
      it { expect(subject).to eq(true) }
    end

    context "「アスミス」を含むとき" do
      let(:keyword) { "いぇっす！アスミス！" }
      it { expect(subject).to eq(true) }
    end

    context "「阿澄佳奈」を含むとき" do
      let(:keyword) { "阿澄佳奈でーす" }
      it { expect(subject).to eq(true) }
    end

    context "「あすみん」しか含んでいないとき" do
      let(:keyword) { "あすみんぺろぺろ" }
      it { expect(subject).to eq(false) }
    end

    context "「佳奈」しか含んでいないとき" do
      let(:keyword) { "佳奈ちゃんまじかわいい" }
      it { expect(subject).to eq(false) }
    end
  end

  describe "#except_check" do
    subject { client.except_check(keyword) }
    context "中田あすみ" do
      let(:keyword) { "中田あすみです" }
      it { expect(subject).to eq(false) }
    end

    context "歌ってみた" do
      let(:keyword) { "あすみんの曲歌ってみた" }
      it { expect(subject).to eq(false) }
    end

    context "弾いてみた" do
      let(:keyword) { "あすみんの曲弾いてみた" }
      it { expect(subject).to eq(false) }
    end

    context "禁止ワードを含んでいないとき" do
      let(:keyword) { "はーてはてはーてなー" }
      it { expect(subject).to eq(true) }
    end
  end
end

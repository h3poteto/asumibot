require 'rails_helper'

RSpec.describe NiconicoClient do
  let(:client) { NiconicoClient.new }

  describe "#login" do
    subject { client.login(ENV["NICONICO_ID"], ENV["NICONICO_PASSWORD"]) }
    it { expect(subject).not_to eq(nil) }
    it { expect(subject).not_to eq("") }
  end

  context "ログイン後" do
    before(:each) do
      client.login(ENV["NICONICO_ID"], ENV["NICONICO_PASSWORD"])
    end
    # 今日の分が必ずしも存在するわけではないのでCIには載せない
    # describe "#get_today_movies" do
    #   subject { client.get_today_movies }
    #   it do
    #     expect{ subject }.to change{ TodayNiconico.count }.from(0)
    #   end
    # end

    describe "#get_popular_movies" do
      subject { client.get_popular_movies }
      it do
        expect{ subject }.to change{ NiconicoPopular.count }.from(0)
      end
    end
  end
end

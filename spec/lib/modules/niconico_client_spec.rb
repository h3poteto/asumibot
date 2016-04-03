require 'rails_helper'

RSpec.describe NiconicoClient do
  let(:client) { NiconicoClient.new }
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

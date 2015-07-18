require 'rails_helper'

describe 'asumi_level:month_ranking' do
  include_context "rake"
  let(:patient) { create(:patient) }

  context "月のつぶやきが20以上のとき" do
    before(:each) do
      Timecop.travel(2.days.ago) do
        @two_days_ago = create(:high_asumi_level, patient: patient)
      end
    end
    it "MonthRankingが生成されること" do
      expect{ subject.invoke }.to change{ MonthRanking.count }.to(1)
    end

    context "レベルが複数登録されているとき" do
      before(:each) do
        Timecop.travel(1.days.ago) do
          @one_days_ago = create(:high_asumi_level, patient: patient)
        end
        month_asumi = @one_days_ago.asumi_count + @two_days_ago.asumi_count
        month_tweet = @one_days_ago.tweet_count + @two_days_ago.tweet_count
        @month_level = month_asumi * 100 / month_tweet
      end
      it "正しい月次レベルが計算されていること" do
        subject.invoke
        expect(patient.reload.month_ranking.level).to eq(@month_level)
      end

      it "過去の分が計上されないこと" do
        Timecop.travel(1.months.ago) do
          create(:high_asumi_level, patient: patient)
        end
        subject.invoke
        expect(patient.reload.month_ranking.level).to eq(@month_level)
      end
    end
  end

  context "月のつぶやきが20以下のとき" do
    before(:each) do
      Timecop.travel(1.days.ago) do
        create(:asumi_level, tweet_count: 10, patient: patient)
      end
    end
    it "レベルが0であること" do
      subject.invoke
      expect(patient.reload.month_ranking.level).to eq(0)
    end
  end
end

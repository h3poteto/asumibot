require 'rails_helper'

describe 'asumi_level:month_ranking', truncation: true do
  include_context "rake"
  let(:patient) { create(:patient) }

  context "月のつぶやきが20以上のとき" do
    context "レベルがひとつだけ登録されているとき" do
      let(:high_asumi_level) {
        Timecop.travel(2.days.ago) do
          create(:high_asumi_level, patient: patient)
        end
      }
      before(:each) do
        high_asumi_level
      end
      it "MonthRankingが生成されること" do
        expect{ subject.invoke }.to change{ MonthRanking.count }.to(1)
      end
    end

    context "レベルが複数登録されているとき" do
      let(:level_two_days_ago) {
        Timecop.travel(2.days.ago) do
          create(:high_asumi_level, patient: patient)
        end
      }
      let(:level_one_days_ago) {
        Timecop.travel(1.days.ago) do
          create(:high_asumi_level, patient: patient)
        end
      }
      let(:monthly_asumi_level) {
        month_asumi = level_one_days_ago.asumi_count + level_two_days_ago.asumi_count
        month_tweet = level_one_days_ago.tweet_count + level_two_days_ago.tweet_count
        month_asumi * 100.0 / month_tweet
      }
      before(:each) do
        monthly_asumi_level
      end
      it "正しい月次レベルが計算されていること" do
        subject.invoke
        expect(patient.reload.month_ranking.level).to eq(monthly_asumi_level)
      end

      it "過去の分が計上されないこと" do
        Timecop.travel(1.months.ago) do
          create(:high_asumi_level, patient: patient)
        end
        subject.invoke
        expect(patient.reload.month_ranking.level).to eq(monthly_asumi_level)
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

namespace :asumi_level do
  desc "calculate month asumi ranking"
  task :month_ranking => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE month_rankings")
    to = Time.current
    from = Time.current.beginning_of_month
    patients = Patient.where(disabled: false).where(locked: false).where(protect: false)
    patients.each do |p|
      month_level = 0
      month_tweet = 0
      month_asumi = 0
      asumi_levels = AsumiLevel.where(patient_id: p.id).where(created_at: from..to)
      asumi_levels.each do |l|
        month_tweet += l.tweet_count.present? ? l.tweet_count : 0
        month_asumi += l.asumi_count.present? ? l.asumi_count : 0
      end
      month_level = month_asumi * 100 / month_tweet if month_tweet != 0 && month_tweet > 20
      MonthRanking.create!(patient_id: p.id, level: month_level)
    end
  end
end

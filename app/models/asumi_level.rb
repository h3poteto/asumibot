# coding: utf-8
class AsumiLevel < ActiveRecord::Base
  attr_accessible :asumi_count, :asumi_word, :patient_id, :tweet_count
  belongs_to :patient

  def self.month_rankings
    user_info = Struct.new("Patient", :id, :name, :level )
    to = Date.today
    from = Date.today.beginning_of_month
    patients = Patient.joins(:asumi_levels).where(:asumi_levels => {created_at: from..to }).where(disabled: false).where(locked: false).where(protect: false)
    rankings = []
    patients.each do |p|
      month_level = 0
      month_tweet = 0
      month_asumi = 0
      p.asumi_levels.each do |l|
        next if l.created_at < from
        month_tweet += l.tweet_count
        month_asumi += l.asumi_count
      end
      month_level = month_asumi * 100 / month_tweet if month_tweet != 0 && month_tweet > 20
      rankings.push(user_info.new(p.id, p.name, month_level))
    end
    rankings.sort! do |a,b|
      b.level <=> a.level
    end
    return rankings
  end
end

# coding: utf-8
class AsumiLevel < ActiveRecord::Base
  belongs_to :patient

  def self.month_rankings
    user_info = Struct.new("Patient", :id, :name, :level )
    to = Time.current
    from = Time.current.beginning_of_month
    patients = Patient.where(disabled: false).where(locked: false).where(protect: false)
    rankings = []
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
      rankings.push(user_info.new(p.id, p.name, month_level))
    end
    rankings.sort! do |a,b|
      b.level <=> a.level
    end
    return rankings
  end
end

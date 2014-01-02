# coding: utf-8
class AsumiLevel < ActiveRecord::Base
  attr_accessible :asumi_count, :asumi_word, :patient_id, :tweet_count
  belongs_to :patient

  # 一月絞り込みがない?
  def self.month_rankings
    user_info = Struct.new("Patient", :id, :name, :level )
    patients = Patient.includes(:asumi_levels).where(disabled: false).where(locked: false).where(protect: false)
    rankings = []
    patients.each do |p|
      month_level = 0
      month_tweet = 0
      month_asumi = 0
      p.asumi_levels.each do |l|
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

class MonthRanking < ActiveRecord::Base
  belongs_to :patient

  scope :level_order, -> { order('level DESC')}
end

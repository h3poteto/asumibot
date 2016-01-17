# == Schema Information
#
# Table name: today_niconicos
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  url         :string(255)
#  description :string(255)
#  priority    :boolean
#  used        :boolean          default(FALSE), not null
#  disabled    :boolean          default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#

class TodayNiconico < ActiveRecord::Base
  validates_uniqueness_of :url
end

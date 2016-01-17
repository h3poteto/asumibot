# == Schema Information
#
# Table name: niconico_populars
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  url         :string(255)
#  description :string(255)
#  priority    :integer
#  used        :boolean          default(FALSE), not null
#  disabled    :boolean          default(FALSE), not null
#  created_at  :datetime
#  updated_at  :datetime
#

class NiconicoPopular < ActiveRecord::Base
  validates_uniqueness_of :url
end

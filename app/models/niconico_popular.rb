# == Schema Information
#
# Table name: niconico_populars
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  url         :string(255)
#  description :text(65535)
#  priority    :integer
#  used        :boolean          default(FALSE), not null
#  disabled    :boolean          default(FALSE), not null
#  created_at  :datetime
#  updated_at  :datetime
#

class NiconicoPopular < ApplicationRecord
  validates_uniqueness_of :url
end

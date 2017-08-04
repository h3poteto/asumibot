# frozen_string_literal: true

# == Schema Information
#
# Table name: blogs
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  link       :string(255)
#  used       :boolean          default(FALSE)
#  post_at    :datetime
#  created_at :datetime
#  updated_at :datetime
#

class Blog < ApplicationRecord
  validates_uniqueness_of :link
end

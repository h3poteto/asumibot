# frozen_string_literal: true

# == Schema Information
#
# Table name: serifs
#
#  id         :integer          not null, primary key
#  type       :string(255)
#  word       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Serif < ApplicationRecord
  validates_uniqueness_of :word
end

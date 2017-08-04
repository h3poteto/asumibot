# frozen_string_literal: true

# == Schema Information
#
# Table name: last_data
#
#  id         :integer          not null, primary key
#  category   :string(255)
#  tweet_id   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class LastData < ApplicationRecord
end

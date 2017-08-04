# frozen_string_literal: true

# == Schema Information
#
# Table name: month_rankings
#
#  id         :integer          not null, primary key
#  patient_id :integer
#  level      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :month_ranking do
    patient
    level { [0..100].sample }
  end

end

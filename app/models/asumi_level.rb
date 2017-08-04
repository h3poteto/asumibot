# coding: utf-8
# == Schema Information
#
# Table name: asumi_levels
#
#  id          :integer          not null, primary key
#  patient_id  :integer
#  asumi_count :integer
#  tweet_count :integer
#  asumi_word  :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class AsumiLevel < ApplicationRecord
  belongs_to :patient

end

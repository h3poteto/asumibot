class AsumiLevel < ActiveRecord::Base
  attr_accessible :asumi_count, :asumi_word, :patient_id, :tweet_count
  belongs_to :patient
end

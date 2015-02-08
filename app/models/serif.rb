class Serif < ActiveRecord::Base
  validates_uniqueness_of :word
end

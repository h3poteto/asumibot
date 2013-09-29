class Serif < ActiveRecord::Base
  attr_accessible :type, :word
  validates_uniqueness_of :word
end

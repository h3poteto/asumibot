class NiconicoMovie < ActiveRecord::Base
  attr_accessible :description, :disabled, :priority, :title, :url
  validates_uniqueness_of :url
end

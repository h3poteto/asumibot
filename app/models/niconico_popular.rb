class NiconicoPopular < ActiveRecord::Base
  attr_accessible :description, :disabled, :priority, :title, :url, :used
  validates_uniqueness_of :url
end

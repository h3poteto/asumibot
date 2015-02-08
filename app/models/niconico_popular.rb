class NiconicoPopular < ActiveRecord::Base
  validates_uniqueness_of :url
end

class Blog < ActiveRecord::Base
  attr_accessible :link, :post_at, :title, :used
  validates_uniqueness_of :link
end

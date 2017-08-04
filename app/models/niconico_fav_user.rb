# frozen_string_literal: true

# == Schema Information
#
# Table name: niconico_fav_users
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  niconico_movie_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class NiconicoFavUser < ApplicationRecord
  belongs_to :fav_niconico, :class_name => 'NiconicoMovie', :foreign_key => :niconico_movie_id
  belongs_to :fav_user, :class_name => 'User', :foreign_key => :user_id

  def self.recent(period=1.week.ago)
    to = Time.current
    if period.present?
      new_fav = self.where(created_at: period...to).order("created_at DESC")
    else
      new_fav = self.order("created_at DESC").all
    end
    movie_ids = new_fav.map{|r| r.niconico_movie_id }
    movie_ids.uniq!
    count=[]
    movie_ids.each do |id|
      movie = NiconicoMovie.find(id)
      count.push([movie, fav_count(id)]) unless movie.disabled
    end
    count.sort!{|a,b|
      b[1] <=> a[1]
    }
    #raise count.inspect
    return count
  end

  def self.fav_count(id)
    rt_movie = self.where(niconico_movie_id: id.to_i)
    return rt_movie.count
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: niconico_rt_users
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  niconico_movie_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class NiconicoRtUser < ApplicationRecord
  belongs_to :rt_niconico, :class_name => 'NiconicoMovie', :foreign_key => :niconico_movie_id
  belongs_to :rt_user, :class_name => 'User', :foreign_key => :user_id

  def self.recent(period=1.week.ago)
    to = Time.current
    if period.present?
      new_rt = self.where(created_at: period...to).order("created_at DESC")
    else
      new_rt = self.order("created_at DESC").all
    end
    movie_ids = new_rt.map{|r| r.niconico_movie_id }
    movie_ids.uniq!
    count=[]
    movie_ids.each do |id|
      movie = NiconicoMovie.find(id)
      count.push([movie, rt_count(id)]) unless movie.disabled
    end
    count.sort!{|a,b|
      b[1] <=> a[1]
    }
    #raise count.inspect
    return count
  end

  def self.rt_count(id)
    rt_movie = self.where(niconico_movie_id: id.to_i)
    return rt_movie.count
  end
end

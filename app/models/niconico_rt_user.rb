class NiconicoRtUser < ActiveRecord::Base
  belongs_to :rt_niconico, :class_name => 'NiconicoMovie', :foreign_key => :niconico_movie_id
  belongs_to :rt_user, :class_name => 'User', :foreign_key => :user_id

  def self.ranking(period=nil)
    to = Date.today
    if period.present?
      ranking = self.where(created_at: period...to).order("niconico_movie_id")
    else
      ranking = self.order("niconico_movie_id").all
    end
    # count
    rank_movie = ranking.map{|r| r.niconico_movie_id }
    ranking = rank_movie.count
    count = []
    ranking.each do |r|
      movie = NiconicoMovie.find(r[0])
      count.push({r[1]=>movie})
    end
    return count
  end
end

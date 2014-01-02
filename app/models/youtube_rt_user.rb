class YoutubeRtUser < ActiveRecord::Base
  belongs_to :rt_youtube, :class_name => 'YoutubeMovie', :foreign_key => :youtube_movie_id
  belongs_to :rt_user, :class_name => 'User', :foreign_key => :user_id

  def self.ranking(period=nil)
    to = Date.today
    if period.present?
      ranking = self.where(created_at: period...to).order("youtube_movie_id")
    else
      ranking = self.order("youtube_movie_id").all
    end
    # count
    rank_movie = ranking.map{|r| r.youtube_movie_id }
    ranking = rank_movie.count
    count = []
    ranking.each do |r|
      movie = YoutubeMovie.find(r[0])
      count.push({r[1]=>movie})
    end
    return count
  end
end

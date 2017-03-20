require 'sanitize'

class NiconicoClient
  def initialize
    @watch_path = 'http://www.nicovideo.jp/watch/'
    @niconico_tags = ['阿澄佳奈', '阿澄病']
    @niconico_search = ['阿澄佳奈', '阿澄病', 'アスミス']
  end


  def get_today_movies()
    @niconico_search.each do |keyword|
      nico = NiconicoSearch::Client.new("asumibot")
      results = nico.search(
        query: keyword,
        targets: [:title, :description, :tags],
        options: {
          _limit: 50,
          "filters[start_time][gte]" => Time.current.yesterday.beginning_of_day.strftime("%Y-%m-%dT%H:%M:%S%:z"),
          "filters[start_time][lte]" => Time.current.beginning_of_day.strftime("%Y-%m-%dT%H:%M:%S%:z")
        }
      )

      results.each do |r|
        add_niconicos(r)
        add_today_niconicos(r)
      end
    end
  end

  def get_popular_movies
    @niconico_tags.each do |tag|
      nico = NiconicoSearch::Client.new("asumibot")
      results = nico.search(
        query: tag,
        targets: [:tags],
        options: {
          _limit: 50,
          _sort: :lastCommentTime
        }
      )

      results.each_with_index do |r, i|
        add_niconicos(r)
        add_popular_niconicos(r, i)
      end
    end
  end


  private

  # 本当はdbとしてユニーク制約を張っておきたいが，現状はモデルのバリデータでユニーク制約を担保できている
  def add_popular_niconicos(movie, priority)
    NiconicoPopular.create(
      title: Sanitize.clean(movie.title),
      url: @watch_path + movie.contentId,
      description: Sanitize.clean(movie.description),
      priority: priority
    )
  end

  def add_today_niconicos(movie)
    TodayNiconico.create(
      title: Sanitize.clean(movie.title),
      url: @watch_path + movie.contentId,
      description: Sanitize.clean(movie.description),
      priority: nil
    )
  end

  def add_niconicos(movie)
    NiconicoMovie.create(
      title: Sanitize.clean(movie.title),
      url: @watch_path + movie.contentId,
      description: Sanitize.clean(movie.description),
      priority: nil
    )
  end
end

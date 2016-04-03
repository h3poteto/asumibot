require 'nico_search_snapshot'
require 'sanitize'

class NiconicoClient
  def initialize
    @watch_path = 'http://www.nicovideo.jp/watch/'
    @niconico_tags = ['阿澄佳奈', '阿澄病']
    @niconico_search = ['阿澄佳奈', '阿澄病', 'アスミス']
  end


  def get_today_movies()
    @niconico_search.each do |keyword|
      nico = NicoSearchSnapshot.new("asumibot")
      results = nico.search(
        keyword,
        search: [:title, :description, :tags],
        size: 19,
        filters: [
          {
            type: :range,
            field: :start_time,
            from: Time.current.yesterday.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S"),
            to: Time.current.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S"),
            include_upper: false
          }
        ]
      )
      results.each do |r|
        add_niconicos(r)
        add_today_niconicos(r)
      end
    end
  end

  def get_popular_movies
    @niconico_tags.each do |tag|
      nico = NicoSearchSnapshot.new("asumibot")
      # 現状sizeで20以上指定をすると返却値のエンコードがおかしくなる
      results = nico.search(
        tag,
        search: [:tags_exact],
        sort_by: :last_comment_time,
        size: 15
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
      url: @watch_path + movie.cmsid,
      description: Sanitize.clean(movie.description),
      priority: priority
    )
  end

  def add_today_niconicos(movie)
    TodayNiconico.create(
      title: Sanitize.clean(movie.title),
      url: @watch_path + movie.cmsid,
      description: Sanitize.clean(movie.description),
      priority: nil
    )
  end

  def add_niconicos(movie)
    NiconicoMovie.create(
      title: Sanitize.clean(movie.title),
      url: @watch_path + movie.cmsid,
      description: Sanitize.clean(movie.description),
      priority: nil
    )
  end
end

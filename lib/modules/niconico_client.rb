require 'open-uri'

class NiconicoClient
  attr_reader :host, :search, :tag, :watch_path, :cookie
  def initialize
    @host = 'http://ext.nicovideo.jp'
    @search = '/api/search/search/'
    @tag = '/api/search/tag/'
    @watch_path = 'http://www.nicovideo.jp/watch/'
    @niconico_tags = ['阿澄佳奈', '阿澄病']
    @niconico_search = ['阿澄佳奈', '阿澄病', 'アスミス']
  end

  def login(email, password)
    loginhost = 'secure.nicovideo.jp'
    path = '/secure/login?site=niconico'
    body = "mail=#{email}&password=#{password}"

    https = Net::HTTP.new(loginhost, 443)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_NONE
    response = https.start { |https|
      https.post(path, body)
    }

    @cookie = ''
    response['set-cookie'].split('; ').each do |st|
      if idx=st.index('user_session_')
        @cookie = "user_session=#{st[idx..-1]}"
        break
      end
    end

    @cookie
  end

  def get_today_movies()
    options = '?mode=watch&page=1&sort=f&order=d'
    @niconico_search.each do |keyword|
      result = []
      open(@host + @search + URI.encode(keyword) + options, 'Cookie' => @cookie){ |f|
        f.each_line{ |line| result.push(JSON.parse(line))}
      }
      t = Time.current
      str_t = t.strftime("%y/%m/%d")
      next if result[0]["list"].blank?
      result[0]["list"].each do | movie |
        post = movie["first_retrieve"]
        str_post = Date.parse(post[0..9]).strftime("%y/%m/%d")
        if str_post == str_t
          add_niconicos(movie)
          add_today_niconicos(movie)
        end
      end
    end
  end

  def get_popular_movies
    @niconico_tags.each do |tag|
      for i in 0..1 do
        result = []
        options = '?mode=watch&page=' + (i+1).to_s + '&sort=n&order=d'

        open(@host + @tag + URI.encode(tag) + options, 'Cookie' => @cookie){ |f|
          f.each_line{ |line| result.push(JSON.parse(line))}
        }

        if result[0]["status"] != "fail" && result[0]["list"].present?
          pop = i * 32 + 1
          result[0]["list"].each do | movie |
            add_niconicos(movie)
            add_popular_niconicos(movie, pop)
            pop += 1
          end
        end
      end
    end
  end

  def add_popular_niconicos(movie, priority)
    NiconicoPopular.create(title: movie["title"], url: @watch_path + movie["id"], description: movie["description_short"], priority: priority )
  end

  def add_today_niconicos(movie)
    TodayNiconico.create(title: movie["title"], url: @watch_path + movie["id"], description: movie["description_short"], priority: nil)
  end

  def add_niconicos(movie)
    NiconicoMovie.create(title: movie["title"], url: @watch_path + movie["id"], description: movie["description_short"], priority: nil )
  end
end

# coding: utf-8
require 'open-uri'
require 'json'

namespace :niconico do
  HOST = 'http://ext.nicovideo.jp'
  SEARCH = '/api/search/search/'
  TAG = '/api/search/tag/'
  keywords = URI.encode('阿澄佳奈')
  @watch_path = 'http://www.nicovideo.jp/watch/'
  @niconico_words = ['阿澄','あすみ','アスミ','もこたん']
  @niconico_tags = ['阿澄佳奈']

  desc "new nicovideo movie get"
  task :new => :environment do
    @result = []
    cookie = login(Settings.nicovideo.mail_address, Settings.nicovideo.password)
    options = '?mode=watch&page=1&sort=f&order=d'
    open(HOST + SEARCH + keywords + options, 'Cookie' => cookie){ |f|
      f.each_line{ |line| @result.push(JSON.parse(line))}
    }
    t = Date.today
    str_t = t.strftime("%y/%m/%d")
    @result[0]["list"].each do | movie |
      post = movie["first_retrieve"]
      str_post = Date.parse(post[0..9]).strftime("%y/%m/%d")
      add_niconico(movie, true) if str_post == str_t
    end
  end

# niconicoAPIのアクセス制限により、5ページずつ、1分間隔でないと取得できない
# errorではなくresultがfailになるのは、アクセス制限
  desc "all nicovideo movie get"
  task :all => :environment do
    cookie = login(Settings.nicovideo.mail_address, Settings.nicovideo.password)
    @niconico_tags.each do | words |
      keywords = URI.encode(words)
      p words
      i = 1
      while true
        @result = []
        options = '?mode=watch&page=' + i.to_s + '&sort=v&order=d'
        i += 1
        begin
          open(HOST + TAG + keywords + options, 'Cookie' => cookie){ |f|
            f.each_line{ |line| @result.push(JSON.parse(line))}
          }
        rescue
          break
        end
        if i >= 51
          break
        end
        if @result[0]["status"] == "fail"
          i -=1
          p i
          sleep(60)
        else
          @result[0]["list"].each do | movie |
            add_niconico(movie, false)
          end
        end
      end

# リバース
      i = 1
      while true
        @result = []
        options = '?mode=watch&page=' + i.to_s + '&sort=v&order=a'
        i += 1
        begin
          open(HOST + TAG + keywords + options, 'Cookie' => cookie){ |f|
            f.each_line{ |line| @result.push(JSON.parse(line))}
          }
        rescue
          break
        end
        if i >= 51
          break
        end
        if @result[0]["status"] == "fail"
          i -=1
          p i
          sleep(60)
        else
          @result[0]["list"].each do | movie |
            add_niconico(movie, false)
          end
        end
      end
    end
  end

  desc "popular nicovideo movie get"
  task :popular => :environment do
    cookie = login(Settings.nicovideo.mail_address, Settings.nicovideo.password)

    for i in 0..1 do
      @result = []
      options = '?mode=watch&page=' + (i+1).to_s + '&sort=n&order=d'

      open(HOST + TAG + keywords + options, 'Cookie' => cookie){ |f|
        f.each_line{ |line| @result.push(JSON.parse(line))}
      }
      if @result[0]["status"] != "fail"
        pop = i * 32 + 1
        @result[0]["list"].each do | movie |
          popular_data = NiconicoPopular.create(title: movie["title"], url: @watch_path + movie["id"], description: movie["description_short"], priority: pop )
          popular_data.save
          pop += 1
        end
      end
    end
  end

  desc "clear db"
  task :clear => :environment do
    NiconicoPopular.delete_all(["created_at < ?","Today"])
    TodayNiconico.delete_all(["created_at < ?", "Today"])
  end

######################################
# 関数定義
######################################
  private
  def login( mail, pass )
    host = 'secure.nicovideo.jp'
    path = '/secure/login?site=niconico'
    body = "mail=#{mail}&password=#{pass}"

    https             = Net::HTTP.new(host, 443)
    https.use_ssl     = true
    https.verify_mode = OpenSSL::SSL::VERIFY_NONE
    response          = https.start { |https|
      https.post(path, body)
    }

    cookie = ''
    response['set-cookie'].split('; ').each do |st|
      if idx=st.index('user_session_')
        cookie = "user_session=#{st[idx..-1]}"
        break
      end
    end

    return cookie
  end

  def add_niconico(movie, new_flag)
    if new_flag
      today_data = TodayNiconico.create(title: movie["title"], url: @watch_path + movie["id"], description: movie["description_short"], priority: nil)
      today_data.save
    end
    new_data = NiconicoMovie.create(title: movie["title"], url: @watch_path + movie["id"], description: movie["description_short"], priority: nil )
    new_data.save
  end
end

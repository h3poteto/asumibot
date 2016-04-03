# coding: utf-8

namespace :niconico do

  desc "new nicovideo movie get"
  task :new => :environment do
    client = NiconicoClient.new
    client.get_today_movies
  end

  desc "popular nicovideo movie get"
  task :popular => :environment do
    client = NiconicoClient.new
    client.get_popular_movies
  end

  desc "clear db"
  task :clear => :environment do
    NiconicoPopular.delete_all(["created_at < ?","Today"])
    TodayNiconico.delete_all(["created_at < ?", "Today"])
  end

=begin
  初回しか必要ないメソッドのため廃止
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
=end

end

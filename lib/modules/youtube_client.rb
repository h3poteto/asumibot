require 'google/api_client'
class YoutubeClient
  attr_reader :client, :youtube, :search_result
  def initialize
    @client = Google::APIClient.new(
      key: ENV["DEVELOPER_KEY"],
      authorization: nil,
      application_name: Rails.application.class.parent_name,
      application_version: '1.0.0'
    )

    @youtube = client.discovered_api('youtube', 'v3')

    @asumi_word = ['阿澄','アスミス','阿澄佳奈']
    @except_word = ['中田あすみ','東方','シルクロード','歌ってみた','明日美','hito20','明日実','ピストン西沢','ふぉんだんみんと','mariavequoinette','http://www.reponet.tv','アカツキ','弾いてみた','やってみた','湾岸','太鼓さん次郎','明治神宮','踊ってみた']
    @search_words = ['阿澄佳奈','阿澄さん','アスミス']
    @search_result = []
  end

  def search(opts)
    @search_words.each do |search_word|
      begin
        search_response = client.execute!(
          api_method: youtube.search.list,
          parameters: opts.merge!({
            part: 'snippet',
            q: search_word
          })
        )

        search_response.data.items.each do |result|
          case result.id.kind
          when 'youtube#video'
            search_result << result
          else
            # list channelには興味が無い
          end

        end
      rescue Google::APIClient::TransmissionError => e
        puts e.result.body
      end
    end
  end

  def asumi_check(word)
    @asumi_word.each do |asumi|
      return true if word.include?(asumi)
    end
    return false
  end

  def except_check(word)
    @except_word.each do |except|
      return false if word.include?(except)
    end
    return true
  end

  def add_youtube(result)
    if except_check(result.snippet.title) && except_check(result.snippet.description)
      ## サムネイル登録したいときはここでできるよ
      ## urlが被る可能性があるので例外は出さない
      ## protocolはhttpでもhttpsでもview側で適切に処理している
      YoutubeMovie.create(
        title: result.snippet.title,
        url: "https://www.youtube.com/watch?v=#{result.id.videoId}&feature=youtube_gdata_player",
        description: result.snippet.description
      )
    end
  end

  def add_today_youtubes(result)
    if except_check(result.snippet.title) && except_check(result.snippet.description)
      TodayYoutube.create(
        title: result.snippet.title,
        url: "https://www.youtube.com/watch?v=#{result.id.videoId}&feature=youtube_gdata_player",
        description: result.snippet.description
      )
    end
  end

  def add_popular_youtubes(result)
    if except_check(result.snippet.title) && except_check(result.snippet.description)
      YoutubePopular.create(
        title: result.snippet.title,
        url: "https://www.youtube.com/watch?v=#{result.id.videoId}&feature=youtube_gdata_player",
        description: result.snippet.description
      )
    end
  end

  def update_today
    search_result.each do |result|
      case result.id.kind
      when 'youtube#video'
        add_today_youtubes(result)
        add_youtube(result)
      end
    end
  end

  def update_popular
    search_result.each do |result|
      case result.id.kind
      when 'youtube#video'
        add_popular_youtubes(result)
        add_youtube(result)
      end
    end
  end
end

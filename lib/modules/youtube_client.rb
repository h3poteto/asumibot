require 'google/api_client'
class YoutubeClient
  attr_reader :client, :youtube
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
    @search_words = ['阿澄佳奈','阿澄さん','アスミス','もこたん']
  end

  def search(opts)
    @search_words.each do |search_word|
      begin
        search_response = client.execute!(
          api_method: youtube.search.list,
          parameters: {
            part: 'snippet',
            q: search_word,
            maxResults: opts[:max_results],
            order: opts[:order],
            type: opts[:type],
            publishedAfter: opts[:published_after]
          }
        )

        search_response.data.items.each do |search_result|
          case search_result.id.kind
          when 'youtube#video'
            add_youtube(search_result)
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
end

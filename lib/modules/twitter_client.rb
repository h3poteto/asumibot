class TwitterClient
  attr_reader :client
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key       = Settings.twitter.consumer_key
      config.consumer_secret    = Settings.twitter.consumer_secret
      config.access_token        = Settings.twitter.oauth_token
      config.access_token_secret = Settings.twitter.oauth_token_secret
    end
  end

  # TODO: urlはtweetの長さとは分離する
  def update(tweet, url)
    begin
      @client.update(trim(tweet, url).chomp)
    rescue => e
      Rails.logger.error "<<twitter.rake::tweet.update ERROR : " + e.message + ">>"
      return false
    end
    return true
  end

  def trim(tweet, url)
    if url.present?
      if (tweet + url).length > 140
        # urlは短縮されるので23文字残っていれば十分
        tweet = tweet[0..(140 - 26)].to_s + "… " + url
      else
        tweet += " " + url
      end
    else
      tweet = tweet[0..138].to_s + "…"
    end
    tweet
  end
end

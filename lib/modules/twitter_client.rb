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
      if (tweet + url).length > 140
        tweet = tweet[0..(130 - url.length)].to_s + "...\n" + url
      else
        tweet += url
      end
      tweet = (tweet.length > 140) ? tweet[0..139].to_s : tweet
      @client.update(tweet.chomp)
    rescue => e
      Rails.logger.error "<<twitter.rake::tweet.update ERROR : " + e.message + ">>"
      return false
    end
    return true
  end
end

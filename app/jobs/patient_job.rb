# coding: utf-8
class PatientJob < ActiveJob::Base
  queue_as :default

  def perform(user_id, text, id, created_at)
    @asumi_tweet = ["阿澄","あすみ","佳奈","アスミ","もこたん","もこちゃ"]
    follower = Patient.where(twitter_id: user_id).first
    if follower.present?
      if asumi_tweet_check(text)
        asumi_tweet = AsumiTweet.new(patient_id: follower.id, tweet: text, tweet_id: id, tweet_time: created_at)
        asumi_tweet.save!
        follower.asumi_count += 1 rescue follower.asumi_count = 1
        follower.tweet_count += 1 rescue follower.tweet_count = 1
      else
        follower.tweet_count += 1 rescue follower.tweet_count = 1
      end
      tweet = asumi_tweet_count(text)
      follower.asumi_word += tweet rescue follower.asumi_word = tweet
      follower.since_id = id.to_s
      follower.save!
    end
  end

  private
  def asumi_tweet_check(word)
    expand_url = ""
    doc = ""
    if word.include?("https:")
      http_url = word.gsub('https:','http:')
      begin
        expand_url = UrlExpander::Client.expand(http_url) if http_url.include?("http:")
      rescue
        expand_url = nil
      end
    else
      begin
        expand_url = UrlExpander::Client.expand(word) if word.include?("http:")
      rescue
        expand_url = nil
      end
    end
    if expand_url.present?
      begin
        uri = URI(expand_url)
        doc = Nokogiri::XML(uri.read).text
      rescue
        doc = "error"
      end
    end
    @asumi_tweet.each do |asumi|
      return true if word.include?(asumi)
      return true if doc.include?(asumi)
    end
    return false
  end
  def asumi_tweet_count(word)
    count = 0
    @asumi_tweet.each do |asumi|
      count += word.scan(/#{asumi}/).length
    end
    return count.to_i
  end
end

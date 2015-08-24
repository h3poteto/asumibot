class AsumiTweet < ActiveRecord::Base
  belongs_to :patient

  before_save :encode_emoji

  def encode_emoji
    self.tweet = utf8mb4_encode_numericentity(self.tweet)
  end

  def utf8mb4_encode_numericentity(str)
    str.gsub(/[^\u{0}-\u{FFFF}]/) { '&#x%X;' % $&.ord }
  end
end

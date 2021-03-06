# coding: utf-8
require 'open-uri'
require 'rss'

namespace :rss do
  desc "update rss"
  task :recent => :environment do
    rss = RSS::Parser.parse(Settings.site.blog)
    item = rss.item
    already = Blog.where(link: item.link)
    unless already.present? && already.length > 0
      b = Blog.new(title: item.title, link: item.link, post_at: item.date )
      b.save!
    end

    client = TwitterClient.new
    content = Blog.where(used: false).order("created_at DESC").first
    if content.present?
      client.update("【あすみんブログ更新】『#{content.title}』", content.link)
      content.update_attributes!(used: true)
    end
  end

  desc "all rss"
  task :all => :environment do
    rss = RSS::Parser.parse(Settings.site.blog)
    rss.items.each do |item|
      item = Blog.new(title: item.title, link: item.link, used: true, post_at: item.date )
      item.save!
    end
  end

end

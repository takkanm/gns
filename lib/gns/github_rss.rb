require 'rss'
require 'open-uri'

module Gns
  class GithubRss
    def initialize(url, start_time = Time.now)
      @url = url
      @last_updated = start_time
    end

    def recent_items
      get_rss_items.find_all {|item|
        item.updated > @last_updated
      }.tap {|items|
        @last_updated = items.first.updated if items.first
      }
    end

    def get_rss_items
      RSS::Parser.parse(open(@url)).items.map {|item|
        GithubItem.new(item)
      }
    end
  end

  class GithubItem
    attr_reader :updated, :title, :url, :body, :repo

    def initialize(rss_item)
      @updated = rss_item.updated.content
      @title = rss_item.title.content
      @url = rss_item.link.href
      rss_item.content.content =~ /<p>(.*)<\/p>/
      @body = $1
      rss_item.content.content =~ /<a.*>(.*)<\/a>/
      @repo = $1
    end
  end
end

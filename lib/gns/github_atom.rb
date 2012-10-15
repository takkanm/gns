require 'rss'
require 'open-uri'

module Gns
  class GithubAtom
    def initialize(url, start_time = Time.now)
      @url = url
      @last_updated = start_time
    end

    def recent_items
      get_atom_items.find_all {|item|
        item.updated > @last_updated
      }.tap {|items|
        @last_updated = items.first.updated if items.first
      }
    end

    def get_atom_items
      RSS::Parser.parse(open(@url)).items.map {|item|
        GithubItem.new(item)
      }
    end
  end

  class GithubItem
    attr_reader :updated, :title, :url, :body, :repo

    def initialize(atom_item)
      @updated = atom_item.updated.content
      @title = atom_item.title.content
      @url = atom_item.link.href
      atom_item.content.content =~ /<p>(.*)<\/p>/
      @body = $1
      atom_item.content.content =~ /<a.*>(.*)<\/a>/
      @repo = $1
    end
  end
end

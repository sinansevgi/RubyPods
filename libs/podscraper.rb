# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class Feed
  attr_reader :title
  attr_reader :pod_image
  attr_reader :result_titles
  attr_reader :result_links
  def initialize(url)
    @url = Nokogiri::XML(URI.open(url))
    @title = @url.css('title')[0].text
    @cast_list = @url.css('enclosure')
    @pod_image = @url.css('image').css('url').text
    fetch_titles
    fetch_links
  end

  def fetch_titles
    @result_titles = []
    all_titles = @url.css('title')
    index = 1
    until result_titles.length == 10
      title = all_titles[index]
      @result_titles.push(title.text) unless title.text == @title
      index += 1
    end
  end

  def fetch_links
    @result_links = []
    @cast_list.each do |cast|
      @result_links.push(cast.attributes['url'].value)
      break if result_links.length == 10
    end
  end

end

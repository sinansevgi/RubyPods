require 'nokogiri'

class Pods
  attr_accessor :pod_links
  def initialize(file_link = './assets/pods.xml')
    @file_link = file_link
    @pod_list = File.open(@file_link) { |f| Nokogiri::XML(f) }
    @pod_links = @pod_list.css('link')
  end

  def list_pods
    @result = []
    @pod_links.each do |link|
      @result.push(link.content)
    end
    @result
  end

  def add_pod(url)
    return false if url.nil? || url == ' '

    @pod_link = Nokogiri::XML::Node.new 'link', @pod_list
    @pod_link.content = url
    @pod_links[-1].add_next_sibling(@pod_link)
    File.write(@file_link, @pod_list)
  end

  def remove_pod(url)
    @pod_links.each do |link|
      next unless link.content == url

      link.remove
      File.write(@file_link, @pod_list)
      break
    end
  end
end

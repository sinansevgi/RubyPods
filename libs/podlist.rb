require 'nokogiri'

class Pods
  attr_accessor :pod_links
  def initialize
    @pod_list = File.open('./assets/pods.xml') { |f| Nokogiri::XML(f) }
    @pod_links = @pod_list.css('link')
  end

  # @return [Podcast List]
  def list_pods
    @result = []
    @pod_links.each do |link|
      @result.push(link.content)
    end
    @result
  end

  def add_pod(url)
    @pod_link = Nokogiri::XML::Node.new 'link', @pod_list
    @pod_link.content = url
    @pod_links[-1].add_next_sibling(@pod_link)
    File.write('./assets/pods.xml', @pod_list)
  end

  def remove_pod(url)
    @pod_links.each do |link|
      next unless link.content == url

      link.remove
      File.write('./assets/pods.xml', @pod_list)
      break
    end
    puts 'Wrong URL'
  end

end

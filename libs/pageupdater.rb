require 'nokogiri'

class Pager
  def initialize(pod_title, pod_image, result_titles, result_links)
    @doc = File.open('./results.html') { |f| Nokogiri::HTML(f) }
    @pod_title = pod_title
    @pod_image = pod_image
    @result_titles = result_titles
    @result_links = result_links
  end

  def block_creator(link, text)
    @block = Nokogiri::XML::Node.new 'div', @doc
    @block.set_attribute('class', 'my-3 p-3 bg-white rounded shadow-sm')
    block_child = Nokogiri::XML::Node.new 'div', @doc
    block_child.set_attribute('class', 'media text-muted pt-3')
    block_image = Nokogiri::XML::Node.new 'img', @doc
    block_image.set_attribute('class', 'image mr-2 rounded')
    block_image.set_attribute('src', @pod_image)
    block_def = Nokogiri::XML::Node.new 'p', @doc
    block_def.set_attribute('class', 'media-body pb-3 mb-0 small lh-125 border-bottom border-gray')
    pod_audio = Nokogiri::XML::Node.new 'audio', @doc
    pod_source = Nokogiri::XML::Node.new 'source', @doc
    pod_audio.set_attribute('controls', '')
    pod_source.set_attribute('src', link)
    pod_source.set_attribute('type', 'audio/mpeg')
    pod_audio.add_child(pod_source)
    block_def.content = text
    block_def.add_child(pod_audio)
    block_child.add_child(block_image)
    block_child.add_child(block_def)
    @block.add_child(block_child)
    @block
  end

  def page_update
    update_time = @doc.at_css '.up'
    p update_time
    update_time.content = 'Last Update: ' + Time.now.strftime('%d/%m/%Y %H:%M')
    main = @doc.at_css '.results'
    main.content = ''
    10.times do |index|
      main.add_child(block_creator(@result_links[index], @result_titles[index]))
    end
    result_page = @doc.to_html
    File.write('results.html', result_page)
  end
end

require 'nokogiri'

class Pager
  def initialize(pod_title, pod_image, result_titles, result_links)
    @doc = File.open('./results.html') { |f| Nokogiri::HTML(f) }
    @pod_title = pod_title
    @pod_image = pod_image
    @result_titles = result_titles
    @result_links = result_links
  end

  def block_init
    @block_child = Nokogiri::XML::Node.new 'div', @doc
    @block_child.set_attribute('class', 'media text-muted pt-3')
    @block_image = Nokogiri::XML::Node.new 'img', @doc
    @block_image.set_attribute('class', 'image mr-2 rounded')
    @block_image.set_attribute('src', @pod_image)
    @block_def = Nokogiri::XML::Node.new 'p', @doc
    @block_hed = Nokogiri::XML::Node.new 'h5', @doc
    @block_bod = Nokogiri::XML::Node.new 'div', @doc
    @block_bod.set_attribute('class', 'media-body')
    @block_def.set_attribute('class', 'pb-3 mb-0 small lh-125 border-bottom border-gray')
    @pod_audio = Nokogiri::XML::Node.new 'audio', @doc
    @pod_source = Nokogiri::XML::Node.new 'source', @doc
  end

  def block_nester(link, text)
    @block = Nokogiri::XML::Node.new 'div', @doc
    @block.set_attribute('class', 'my-3 p-3 bg-white rounded shadow-sm')
    block_init
    @pod_audio.set_attribute('controls', '')
    @pod_source.set_attribute('src', link)
    @pod_source.set_attribute('type', 'audio/mpeg')
    @pod_audio.add_child(@pod_source)
    @block_hed.content = text
    @block_def.add_child(@pod_audio)
    @block_child.add_child(@block_image)
    @block_bod.add_child(@block_hed)
    @block_bod.add_child(@block_def)
    @block_child.add_child(@block_bod)
    @block.add_child(@block_child)
    @block
  end

  def page_update(len = 2)
    update_time = @doc.at_css '.up'
    update_time.content = 'You can update results with running main.rb => ' + 'Last Update: ' + Time.now.strftime('%d/%m/%Y %H:%M')
    main = @doc.at_css '.results'
    pod_tag = @pod_title.split(' ').join('-')
    @doc.at_css('.' + pod_tag)&.remove
    section_heading = Nokogiri::XML::Node.new 'h2', @doc
    section = Nokogiri::XML::Node.new 'div', @doc
    section_heading.content = @pod_title
    section_heading.set_attribute('class', 'mt-5')
    section.set_attribute('class', pod_tag)
    section.add_child(section_heading)
    len.times do |index|
      section.add_child(block_nester(@result_links[index], @result_titles[index]))
    end
    main.add_child(section)
    result_page = @doc.to_html
    File.write('./results.html', result_page)
  end
end

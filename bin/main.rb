require_relative '../libs/podscraper'
require_relative '../libs/podlist'
require_relative '../libs/pageupdater'
require 'progress_bar'

system('clear')
puts '██████╗ ██╗   ██╗██████╗ ██╗   ██╗    ██████╗  ██████╗ ██████╗  ██████╗ █████╗ ███████╗████████╗███████╗'
puts '██╔══██╗██║   ██║██╔══██╗╚██╗ ██╔╝    ██╔══██╗██╔═══██╗██╔══██╗██╔════╝██╔══██╗██╔════╝╚══██╔══╝██╔════╝'
puts '██████╔╝██║   ██║██████╔╝ ╚████╔╝     ██████╔╝██║   ██║██║  ██║██║     ███████║███████╗   ██║   ███████╗'
puts '██╔══██╗██║   ██║██╔══██╗  ╚██╔╝      ██╔═══╝ ██║   ██║██║  ██║██║     ██╔══██║╚════██║   ██║   ╚════██║'
puts '██║  ██║╚██████╔╝██████╔╝   ██║       ██║     ╚██████╔╝██████╔╝╚██████╗██║  ██║███████║   ██║   ███████║'
puts '╚═╝  ╚═╝ ╚═════╝ ╚═════╝    ╚═╝       ╚═╝      ╚═════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝'
puts "\n\nPress Enter to for menu"
podcast_list = Pods.new

begin
  system('clear')
  puts 'Welcome to Ruby Podcasts'
  puts '1 - Podcast List Options'
  puts '2 - Fetch Latest Podcasts'
  puts 'q - Quit'
  input_opt = gets.chomp
  raise unless input_opt.include?('1') || input_opt.include?('2') || input_opt.include?('q')
  case input_opt
  when '1'
    system('clear')
    loop do
      puts 's - See available podcasts'
      puts 'a - Add new podcast'
      puts 'd - Delete podcast'
      puts 'q - Quit'
      input_opt = gets.chomp
      case input_opt
      when 's'
        podcast_list.pod_links.each{|podcast| puts podcast}
        next
      when 'a'
        puts "Please enter the rss url that you would like to add to podcast list :"
        pod_url = gets.chomp
        podcast_list.add_pod(pod_url)
        next
      when 'd'
        podcast_list.pod_links.each{|podcast| puts podcast}
        puts "Please enter the rss url that you would like to delete from podcast list :"
        pod_url = gets.chomp
        podcast_list.remove_pod(url)
        next
      else
        puts "Invalid Input"
      end
      break if input_opt == 'q'
    end
  when '2'
    bar = ProgressBar.new(podcast_list.pod_links.length)
    system('clear')
    puts "How many results would you like to fetch from each podcast ? (Default #2)"
    len = gets.chomp
    len = 2 if len.nil? || len == ""
    len = len.to_i
    system('clear')
    puts "Please wait while your results getting created."
    podcast_list.pod_links.each do |podcast|
      bar.increment!
      podder = Feed.new(podcast)
      page_create = Pager.new(podder.title, podder.pod_image, podder.result_titles, podder.result_links)
      page_create.page_update(len)
    end
    system('clear')
    puts "Your results created in result.html file."
    puts "Please open results.html with your browser."
    end

rescue StandardError
  retry
end



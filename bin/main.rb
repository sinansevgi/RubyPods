require_relative '../libs/podscraper'
require_relative '../libs/podlist'
require_relative '../libs/pageupdater'

system('clear')
puts '██████╗ ██╗   ██╗██████╗ ██╗   ██╗    ██████╗  ██████╗ ██████╗  ██████╗ █████╗ ███████╗████████╗███████╗'
puts '██╔══██╗██║   ██║██╔══██╗╚██╗ ██╔╝    ██╔══██╗██╔═══██╗██╔══██╗██╔════╝██╔══██╗██╔════╝╚══██╔══╝██╔════╝'
puts '██████╔╝██║   ██║██████╔╝ ╚████╔╝     ██████╔╝██║   ██║██║  ██║██║     ███████║███████╗   ██║   ███████╗'
puts '██╔══██╗██║   ██║██╔══██╗  ╚██╔╝      ██╔═══╝ ██║   ██║██║  ██║██║     ██╔══██║╚════██║   ██║   ╚════██║'
puts '██║  ██║╚██████╔╝██████╔╝   ██║       ██║     ╚██████╔╝██████╔╝╚██████╗██║  ██║███████║   ██║   ███████║'
puts '╚═╝  ╚═╝ ╚═════╝ ╚═════╝    ╚═╝       ╚═╝      ╚═════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝'
puts "\n\nPress Enter to for menu"
podcast_list = Pods.new
podcast_list.pod_links.each do |podcast|
  podder = Feed.new(podcast)
  page_create = Pager.new(podder.title, podder.pod_image, podder.result_titles, podder.result_links)
  page_create.page_update
end
# begin
#   system('clear')
#   puts 'Welcome to Ruby Podcasts'
#   puts '1 - Podcast List Options'
#   puts '2 - Fetch Latest Podcasts'
#   puts 'q - Quit'
#   input_opt = gets.chomp
#   raise unless input_opt.include?('1') || input_opt.include?('2') || input_opt.include?('q')
#   case input_opt
#   when '1'
#     system('clear')
#     loop do
#       puts 's - See available podcats'
#       puts 'a - Add new podcast'
#       puts 'd - Delete podcast'
#       puts 'q - Quit'
#       break if input_opt == 'q'
#     end
#   when '2'
#
#   end
#
# rescue StandardError
#   retry
# end
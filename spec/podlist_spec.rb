require_relative '../libs/podlist'
require 'nokogiri'
# podlist.rb

describe 'Pods' do
  let(:pod_list) { Pods.new('./assets/test.xml') }
  let(:test_list) do
    %w[https://feeds.feedwrench.com/RubyRoguesOnly.rss https://feeds.transistor.fm/remote-ruby https://feeds.fireside.fm/bikeshed/rss]
  end
  describe 'Pods#initialize' do
    it 'Initialize Pods list object' do
      pod_list.pod_links.length.times do |index|
        expect(pod_list.pod_links[index].content).to eql(test_list[index])
      end
    end
  end
  describe 'Pods#add' do
    it 'Adds new item to list' do
      pod_list.add_pod('https://testuri.com')
      pod_list = Pods.new('./assets/test.xml')
      expect(pod_list.pod_links[-1].content).to eql('https://testuri.com')
      pod_list.remove_pod('https://testuri.com')
    end
  end
  describe 'Pods#remove' do
    it 'Remove given item from list' do
      pod_list.remove_pod('https://feeds.fireside.fm/bikeshed/rss')
      pod_list = Pods.new('./assets/test.xml')
      expect(pod_list.pod_links[-1].content).to eql('https://feeds.transistor.fm/remote-ruby')
      pod_list.add_pod('https://feeds.fireside.fm/bikeshed/rss')
    end
  end
end

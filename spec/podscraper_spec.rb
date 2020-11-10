require_relative '../libs/podscraper'
require 'nokogiri'
require 'open-uri'
# podscraper.rb

describe 'Feed' do
  let(:feed) { Feed.new('./assets/test.rss') }
  describe 'Feed#initialize' do
    it 'Initialize the object' do
      expect(feed.title.nil?).to eql(false)
    end
  end
  describe 'Feed#fetch_titles' do
    it 'Fetches the episode titles' do
      expect(feed.result_titles.length).to eql(10)
    end
  end
  describe 'Feed#fetch_titles fails' do
    it 'Should throw an error if method accessed' do
      expect { feed.fetch_titles }.to raise_error(NoMethodError, /private/)
    end
  end
  describe 'Feed#fetch_links' do
    it 'Fetches the episode links' do
      expect(feed.result_links.length).to eql(10)
    end
  end
  describe 'Feed#fetch_links fails' do
    it 'Should throw an error if method accessed' do
      expect { feed.fetch_links }.to raise_error(NoMethodError, /private/)
    end
  end
end

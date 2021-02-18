require 'httparty'

class CreatePodcastService
  attr_reader :title

  URL = "https://theaussieenglishpodcast.podigee.io/feed/mp3"

  def initialize(title, description, publication_date, image_url, website_url, feed_url)
    @title = title
    @description = description
    @publication_date = publication_date
    @image_url = image_url
    @website_url = website_url
    @feed_url = feed_url
  end

  def self.parse_xml(url)
    xml = HTTParty.get(url).body
    feed = Feedjira.parse(xml)
    # what comes after entries or after feed? check parsed xml
    feed.entries.each do
      @title = feed.title
      @description = feed.description
      @publication_date = feed.pubDate.to_date
      @image_url = feed.image.url
      @website_url = feed.link
      @feed_url =
    end
  end

  def self.create_podcast(title, description, publication_date, image_url, website_url, feed_url)
    Podcast.create!(
      title: @title,
      description: @description,
      publication_date: @publication_date,
      image_url: @image_url,
      website_url: @website_url,
      feed_url: @feed_url
    )
  end
end

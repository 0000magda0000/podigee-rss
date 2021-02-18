require 'httparty'

class CreatePodcastService
  # URL = "https://theaussieenglishpodcast.podigee.io/feed/mp3"
  def initialize(url)
    @url = url
  end

  def parse_xml(url)
    xml = HTTParty.get(url).body
    feed = Feedjira.parse(xml)
    # what comes after entries or after feed? check parsed xml

    @title = feed.title
    @description = feed.description
    @publication_date = feed.last_built.to_date
    @image_url = feed.image.url
    @website_url = feed.url
    @feed_url = feed.url
  end

  def create_podcast
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

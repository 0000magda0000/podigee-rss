require 'httparty'

class CreatePodcastServices
  def parse_xml(url)
    xml = HTTParty.get(url).body
    @feed = Feedjira.parse(xml)
  end

  def create_podcast(parsed_xml)
    Podcast.create!(
      title: @feed.title,
      description: @feed.description,
      publication_date: @feed.last_built.to_date,
      image_url: @feed.image.url.downcase,
      website_url: @feed.url.downcase,
      feed_url: @feed.url.downcase
    )
  end
end

# in `rails console`:
# URL = "https://theaussieenglishpodcast.podigee.io/feed/mp3"
# podcast = CreatePodcastServices.new
# parsed_xml = podcast.parse_xml(URL)
# podcast.create_podcast(parsed_xml)

require 'httparty'

class CreateEpisodeServices

  def parse_xml(url)
    xml = HTTParty.get(url).body
    @feed = Feedjira.parse(xml)
  end

  def create_episodes(parsed_xml)
    @feed.entries.each do |entry|
      # I don't know how to nicely get the responding podcast_id
      podcast_id = if Podcast.where("website_url LIKE ?",
                                      "%#{entry.url}%").first.nil?
                      Podcast.first.id
                    else
                      Podcast.where("website_url LIKE ?",
                                      "%#{entry.url.downcase}%").first.id
                    end
      Episode.create!(
        title: entry.title,
        number: entry.url[/\d+/].to_i,
        description: entry.summary,
        audio_duration: entry.itunes_duration,
        audio_file_url: entry.url.downcase,
        podcast_id: podcast_id
      )
    end
  end
end

# in Rails Console:
# URL = "https://theaussieenglishpodcast.podigee.io/feed/mp3"
# episodes = CreateEpisodeServices.new
# parsed_xml = episodes.parse_xml(URL)
# episodes.create_episodes(parsed_xml)

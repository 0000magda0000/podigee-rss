require 'httparty'

class CreateEpisodeServices

  def initialize(url)
    @url = url
  end

  def parse_xml(url)
    xml = HTTParty.get(url).body
    feed = Feedjira.parse(xml)
    # what comes after entries or after feed? check parsed xml

    feed.entries.each do |entry|
      @title = entry.title
      @number = entry.url[/\d+/].to_i
      @description = entry.summary
      @audio_duration = entry.itunes_duration
      @audio_file_url = entry.url
      if Podcast.where("website_url LIKE ?", "%#{@audio_file_url}%").first.nil?
        @podcast_id = Podcast.first.id
      else
        @podcast_id = Podcast.where("website_url LIKE ?", "%#{@audio_file_url}%").first.id
      end

      @episodes_array = []
      @episodes_array << Episode.new(
        title: @title,
        number: @number,
        description: @description,
        audio_duration: @audio_duration,
        audio_file_url: @audio_file_url.downcase,
        podcast_id: @podcast_id
      )

      @episodes_array.each do |episode|
        episode.save!
      end
    end
  end
end

# URL = "https://theaussieenglishpodcast.podigee.io/feed/mp3"
# episode = CreateEpisodeService.new(URL)
# episode.parse_xml(URL)

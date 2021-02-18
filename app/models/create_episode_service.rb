require 'httparty'

class CreateEpisodeService

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
      @podcast_id = Podcast.where("website_url like ?", "%#{@audio_file_url}%").first.id

      Episode.create!(
        title: @title,
        number: @number,
        description: @description,
        audio_duration: @audio_duration,
        audio_file_url: @audio_file_url,
        podcast_id: @podcast_id
      )
    end
  end
end

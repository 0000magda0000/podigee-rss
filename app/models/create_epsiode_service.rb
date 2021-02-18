require 'httparty'

class CreateEpisode
attr_accessor :title, :number, :description, :audio_duration, :image_url, :audio_file_url

  def initialize(title)
    @title = title
    @number = number
    @description = description
    @audio_duration = audio_duration
    @image_url = image_url
    @audio_file_url = audio_file_url
  end

  def self.parse_xml(url)
    xml = HTTParty.get(url).body
    feed = Feedjira.parse(xml)
    feed.entries.each do |entry|
      @title = entry.title
      @number = entry
      @description =
      @audio_duration =
      @image_url =
      @audio_file_url =
    end
  end

  def self.create_episode(title, description, publication_date, image_url, website_url, feed_url)
    Podcast.create!(
      title: @title,
      description: @description,
      publication_date: @publication_date,
      image_url: @image_url,
      website_url: @website_url,
      feed_url: @feed_url,
      podcast_id: Podcast.first.id
    )
  end
end

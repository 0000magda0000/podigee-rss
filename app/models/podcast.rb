class Podcast < ApplicationRecord
  has_many :episodes
  URL_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validates :image_url, format: { with: URL_REGEXP, message: 'You provided invalid URL' }
  validates :website_url, format: { with: URL_REGEXP, message: 'You provided invalid URL' }
  validates :feed_url, format: { with: URL_REGEXP, message: 'You provided invalid URL' }

end

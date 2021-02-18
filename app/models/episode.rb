class Episode < ApplicationRecord
  belongs_to :podcast
  URL_REGEXP = /\A^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates :audio_file_url, format: { with: URL_REGEXP, message: 'You provided invalid URL' }
end

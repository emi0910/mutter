class Image < ApplicationRecord
  mount_uploader :image, PictureUploader

  validates :image, presence: true
end

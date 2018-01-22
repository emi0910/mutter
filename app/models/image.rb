class Image < ApplicationRecord
  mount_uploader :image, PictureUploader

  default_scope -> { order(created_at: :desc) }

  validates :image, presence: true
end

class Category < ApplicationRecord
  has_many :articles, dependent: :destroy
  mount_uploader :image, PictureUploader

  validates :name, presence: true
  validates :image, presence: true
end

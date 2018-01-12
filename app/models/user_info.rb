class UserInfo < ApplicationRecord
  belongs_to :user

  mount_uploader :icon, PictureUploader
end

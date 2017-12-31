class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
  validates :password, presence: true, length: {minimum: 5, maximum: 255},
            format: {with: /\A[a-z\d]+\z/i}
  has_secure_password
end

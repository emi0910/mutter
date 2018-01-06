class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  VALID_NAME_REGEXP = /\A[a-z\d][a-z\d\-_]+\z/i
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true,
            format: {with: VALID_NAME_REGEXP}
  validates :nickname, length: {maximum: 255}
  validates :password, presence: true, length: {minimum: 5, maximum: 255},
            allow_nil: true
  has_secure_password

  attr_accessor :remember_token

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end

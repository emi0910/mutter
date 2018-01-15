class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category

  default_scope -> { order(created_at: :desc) }
  scope :publicized, -> { where("public = ?", true) }

  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :title,   presence: true
  validates :content, presence: true

  class << self
    def created_by(user_id)
      where("user_id = ?", user_id)
    end

    def belong_to(category_id)
      where("category_id = ?", category_id)
    end
  end
end

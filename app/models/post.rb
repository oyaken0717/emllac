class Post < ApplicationRecord
  validates :title, presence: true, length: {maximum: 140}

  mount_uploader :image, ImageUploader
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  scope :search_title, -> (post_title) { where("title LIKE ?", "%#{ post_title }%") }
end

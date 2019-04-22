class Post < ApplicationRecord
  validates :title, presence: true, length: {maximum: 140}

  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :group

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  scope :search_title, -> (post_title) { where("title LIKE ?", "%#{ post_title }%") }

  has_many :categories, dependent: :destroy
  has_many :tags, through: :categories, source: :tag
  has_many :comments, dependent: :destroy
end

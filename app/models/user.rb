class User < ApplicationRecord
  validates :name, presence: true, length:  { maximum: 30 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  mount_uploader :image, ImageUploader
  has_many :posts
  has_many :favorites, dependent: :destroy
  has_many :comments
  scope :search_name, -> (user_name) { where("name LIKE ?", "%#{ user_name }%") }
end

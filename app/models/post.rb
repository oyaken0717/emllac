class Post < ApplicationRecord
  validates :title, presence: true, length: {maximum: 140}

  mount_uploader :image, ImageUploader
end

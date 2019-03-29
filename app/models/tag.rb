class Tag < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :category_posts, through: :categories, source: :post
end

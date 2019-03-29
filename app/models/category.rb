class Category < ApplicationRecord
  belongs_to :post
  belongs_to :tag
end

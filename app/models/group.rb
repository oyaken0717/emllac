class Group < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_many :groups
  has_many :members, dependent: :destroy
  has_many :member_users, through: :members, source: :user
end

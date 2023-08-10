class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :expenses

  # has_one_attached :image

  validates :name, presence: true

  validates :name, length: { maximum: 50 }
end

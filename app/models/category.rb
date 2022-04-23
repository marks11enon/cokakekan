class Category < ApplicationRecord
  has_many :details
  attachment :image

  validates :name, presence: true
end

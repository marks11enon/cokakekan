class Category < ApplicationRecord
  has_many :details
  attachment :image
end

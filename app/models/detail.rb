class Detail < ApplicationRecord
  belongs_to :user
  belongs_to :month
  belongs_to :category
end

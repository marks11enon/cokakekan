class Budget < ApplicationRecord
  belongs_to :user
  belongs_to :month

  validates :user_id, presence: true
  validates :month_id, presence: true
  validates :amount, presence: true
end

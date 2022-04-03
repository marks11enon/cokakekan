class Month < ApplicationRecord
  belongs_to :user
  has_many :details, dependent: :destroy
  has_one :budget, dependent: :destroy

  validates :user_id, presence: true
  validates :month, presence: true
  validates :balance, presence: true
end

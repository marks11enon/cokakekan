class Detail < ApplicationRecord
  belongs_to :user
  belongs_to :month
  belongs_to :category

  validates :user_id, presence: true
  validates :month_id, presence: true
  validates :category_id, presence: true
  validates :player, presence: true
  validates :status, presence: true
  validates :date, presence: true
  validates :note, length: { maximum: 50 }

  # enum 設定

end

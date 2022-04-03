class Month < ApplicationRecord
  belongs_to :user

  has_many :details, dependent: :destroy
  has_one :budget, dependent: :destroy
end

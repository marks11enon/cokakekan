class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :encrypted_password, presence: true, length: { minimum: 7 }

  has_many :months, dependent: :destroy
  has_many :details, dependent: :destroy
  has_many :budgets, dependent: :destroy
end

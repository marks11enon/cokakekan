class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :months, dependent: :destroy
  has_many :details, dependent: :destroy
  has_many :budgets, dependent: :destroy
end

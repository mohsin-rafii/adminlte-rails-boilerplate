class User < ApplicationRecord
  has_many :posts 

  has_many :user_subscribers, dependent: :destroy
  has_many :subscribers, through: :user_subscribers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

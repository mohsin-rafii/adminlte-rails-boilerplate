class UserSubscriber < ApplicationRecord

  belongs_to :user
  belongs_to :subscriber, class_name: 'User'

end 
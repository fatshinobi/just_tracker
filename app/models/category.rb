class Category < ApplicationRecord
  belongs_to :user
  
  validates :user, presence: true

  scope :for_user, ->(user) { where(user: user) }  
end

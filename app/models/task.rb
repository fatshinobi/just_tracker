class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :category, presence: true
  validates :start, presence: true
  validates :user, presence: true

  scope :currents, ->(user) { where(user: user).where(finish: nil) }
  scope :today, ->(user) { where(user: user).where("start >= '#{Time.now.beginning_of_day}'").order(start: :asc) }
  scope :for_user, ->(user) { where(user: user) }
end

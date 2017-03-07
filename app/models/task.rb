class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :category, presence: true
  validates :start, presence: true
  validates :user, presence: true

  scope :currents, ->(user) { where(user: user).where(finish: nil) }
  scope :to_date, ->(date, user) { where(user: user).where("start >= '#{date.beginning_of_day}'").where("start <= '#{date.end_of_day}'").order(start: :asc) }
  scope :for_user, ->(user) { where(user: user) }
  scope :per_categories, ->(user) {select('categories.name as category_name, sum(finish - start) as during').joins(:category).group('categories.name').where(user: user).where("start >= '#{Time.now.beginning_of_day}'").where("start <= '#{Time.now.end_of_day}'").order('during DESC')}
end

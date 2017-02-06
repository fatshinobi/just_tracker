class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  around_action :user_time_zone

  def user_time_zone(&block)
    user_zone = current_user ? current_user.time_zone : 'UTC'
    Time.use_zone(user_zone, &block)
  end
end

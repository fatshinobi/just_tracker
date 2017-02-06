class SettingsController < ApplicationController
  def index
    @time_zone = current_user.time_zone
  end

  def update
    time_zone = params[:time_zone]
    current_user.time_zone = time_zone
    current_user.save

    redirect_to action: 'index'
  end
end

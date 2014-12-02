class UsersController < ApplicationController
  def profile
  end
  
  def edit_account_details
  end
  
  def update
    @user = current_user
    @user.update!(user_params)
    redirect_to profile_path
  end
  
  def edit_play_schedule
    @days = %w[monday tuesday wednesday thursday friday saturday sunday]
  end
  
  def update_play_schedule
    @user = current_user
    @user.time_slots = TimeSlot.all_time_slots(params[:day])
    @user.save
    redirect_to profile_path
  end
  
  private
  def user_params
    params.require(:user).permit(:gamertag,:postal_code,:date_of_birth, :occupation)
  end
end

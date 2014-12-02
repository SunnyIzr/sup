class UsersController < ApplicationController
  def profile
  end
  def edit_account_details
  end
  def update
    @user = current_user
    @user.update!(user_params)
    redirect_to profile_path(@user)
  end
  
  private
  def user_params
    params.require(:user).permit(:gamertag,:postal_code,:date_of_birth, :occupation)
  end
end

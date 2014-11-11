class SignupRequestsController < ApplicationController
  def create
    @signup_request = SignupRequest.generate_new(signup_request_params[:email])
    redirect_to new_user_registration_path(hex_id: @signup_request.hex_id)
  end
  
  private
  def signup_request_params
    params.require(:signup_request).permit(:email)
  end
end

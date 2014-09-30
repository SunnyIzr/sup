class SignupRequestsController < ApplicationController
  def create
    @signup_request = SignupRequest.generate_new(params[:signup_request][:email])
    redirect_to signup_path(@signup_request.hex_id)
  end

  def show
    @signup_request = SignupRequest.find_by(hex_id: params[:hex_id])
  end
  
  private
  def signup_request_params
    params.permit(:signup_request).permit(:email)
  end
end

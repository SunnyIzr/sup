class SignupRequestsController < ApplicationController
  def create
    @signup_request = SignupRequest.generate_new(signup_request_params[:email])
    render json: 'success'
  end
  
  private
  def signup_request_params
    params.require(:signup_request).permit(:email)
  end
end

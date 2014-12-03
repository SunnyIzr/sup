class StaticPagesController < ApplicationController
  def index
    @signup_request = SignupRequest.new
    @notifications = params[:load] == 'load'
  end
  
  def about
    @signup_request = SignupRequest.new
  end
  
  def contact
    @signup_request = SignupRequest.new
  end
  
  def submit_contact
    UserMailer.new_contact_form_entry(params[:name],params[:email],params[:subject],params[:message])
    sleep(2)
    redirect_to root_path
  end
end

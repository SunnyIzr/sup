class StaticPagesController < ApplicationController
  def index
    @signup_request = SignupRequest.new
    @notifications = params[:load] == 'load'
  end
  
  def about
    @signup_request = SignupRequest.new
  end
end

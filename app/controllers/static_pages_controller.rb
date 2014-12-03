class StaticPagesController < ApplicationController
  def index
    @signup_request = SignupRequest.new
    @notifications = params[:load] == 'load'
  end
  
  def about
  end
end

class StaticPagesController < ApplicationController
  def index
    p '*'*100
    p params
    p 'what'
    @signup_request = SignupRequest.new
    @notifications = params[:notifications] == 'notifications'
    p @notifications
  end
end

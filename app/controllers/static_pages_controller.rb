class StaticPagesController < ApplicationController
  def index
    @signup_request = SignupRequest.new
  end
end

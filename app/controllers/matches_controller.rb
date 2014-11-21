class MatchesController < ApplicationController
  def index
    @user = current_user
    @matches = @user.outstanding_matched_users
  end
end
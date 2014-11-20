class MatchesController < ApplicationController
  def index
    @user = current_user
    @matches = @user.outstanding_matches
  end
end
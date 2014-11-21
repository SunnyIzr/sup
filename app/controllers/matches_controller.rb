class MatchesController < ApplicationController
  def index
    @user = current_user
    if @user.matches.empty?
      @user.generate_new_matches
    end
    @matches = @user.outstanding_matched_users
  end
end
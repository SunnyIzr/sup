class FriendshipsController < ApplicationController
  def index
    @user = current_user
    @friendships = @current_user.friendships
  end
end
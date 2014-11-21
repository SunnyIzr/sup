class FriendshipsController < ApplicationController
  def index
    @user = current_user
    @friendships = @user.friendships
  end
  def show
    @friendship = Friendship.find(params[:id])
    @friend = @friendship.friend
  end
end
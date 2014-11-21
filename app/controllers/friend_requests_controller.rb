class GamesController < ApplicationController
  def create
    @friend_request = FriendRequest.create(friend_request_params)
    @friend_request.requester = current_user
    if @friend_request.save
      redirect_to root_path
    else
      render text: 'ERROR'
    end
  end
end
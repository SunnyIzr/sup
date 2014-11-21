class FriendRequestsController < ApplicationController
  def create
    @friend_request = FriendRequest.create(friend_request_params)
    @friend_request.requester = current_user
    if @friend_request.save
      redirect_to root_path
    else
      render text: 'ERROR'
    end
  end
  
  def show
    @friend_request = FriendRequest.find(params[:id])
  end
  
  private
  def friend_request_params
    params.require(:friend_request).permit(:recipient_id)
  end
end
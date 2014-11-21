class FriendRequestsController < ApplicationController
  def create
    @friend_request = FriendRequest.create(friend_request_params)
    @friend_request.requester = current_user
    if @friend_request.save
      redirect_to notifications_path('load')
    else
      render text: 'ERROR'
    end
  end
  
  def show
    @friend_request = FriendRequest.find(params[:id])
    if @friend_request.recipient == current_user
      @requester = @friend_request.requester
    else
      redirect_to root_path
    end
  end
  
  def accept
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.accept!
    redirect_to notifications_path('load')
  end
  
  def decline
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.decline!
    redirect_to root_path
  end
  
  private
  def friend_request_params
    params.require(:friend_request).permit(:recipient_id)
  end
end
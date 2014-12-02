class MessagesController < ApplicationController
  def index
    @messages = current_user.incoming_messages
    @message = Message.new
    @user = current_user
  end
  
  def sent
    @messages = current_user.sent_messages
    @message = Message.new
    @user = current_user
  end
  
  def deleted
    @messages = current_user.deleted_messages
    @message = Message.new
    @user = current_user
  end
  
  def create
    Message.create(message_params)
    redirect_to sent_messages_path
  end
  
  private
  def message_params
    params.require(:message).permit(:recipient_id, :sender_id, :subject, :body)
  end
end
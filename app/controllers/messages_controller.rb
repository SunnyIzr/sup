class MessagesController < ApplicationController
  def index
    @messages = current_user.incoming_messages
    @message = Message.new
    @user = current_user
  end
  
  def sent
    @messages = current_user.sent_messages.sort_by{|message| message.created_at }.reverse
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
  
  def archive
    @message = Message.find(params[:id])
    @message.update!(deleted: true)
    redirect_to deleted_messages_path
  end
  
  private
  def message_params
    params.require(:message).permit(:recipient_id, :sender_id, :subject, :body)
  end
end
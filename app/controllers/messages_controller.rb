class MessagesController < ApplicationController
  def index
    @messages = current_user.incoming_messages
  end
  
  def sent
    @messages = current_user.sent_messages.sort_by{|message| message.created_at }.reverse
  end
  
  def deleted
    @messages = current_user.deleted_messages
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
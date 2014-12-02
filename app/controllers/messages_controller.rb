class MessagesController < ApplicationController
  def index
    @messages = current_user.incoming_messages
    @message = Message.new
  end
  
  def sent
    @messages = current_user.sent_messages
    @message = Message.new
  end
  
  def deleted
    @messages = current_user.deleted_messages
    @message = Message.new
  end
  
  def create
    p '*'*100
    p params
  end
end
class MessagesController < WebsocketRails::BaseController
  def new
    broadcast_message :chat_receive, message
  end
end
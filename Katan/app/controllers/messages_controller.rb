class MessagesController < WebsocketRails::BaseController
  def new
    broadcast_message :chat_receive, '<span style = "color:blue">' + current_user.name + '</span> : ' + message
  end

  def notice
    broadcast_message :notice, message
  end
end
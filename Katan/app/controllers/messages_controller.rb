class MessagesController < WebsocketRails::BaseController
  include ActionController
  def new
    broadcast_message :chat_receive, '<span style = "color:blue">' + current_user.name + '</span> : ' + message
  end

  def notice
    broadcast_message :notice, message
  end

  def info
    broadcast_message :draw_info, message
  end
end
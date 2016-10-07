class MessagesController < WebsocketRails::BaseController
  include ActionController
  def new
    broadcast_message :chat_receive, '<span style = "color:blue">' + current_user.name + '</span> : ' + ERB::Util.html_escape(message)
  end
end
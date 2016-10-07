WebsocketRails::EventMap.describe do
  subscribe :chat, 'messages#new'
end

WebsocketRails::EventMap.describe do
  subscribe :chat, 'messages#new'
  subscribe :notice, 'messages#notice'
  subscribe :info, 'messages#info'
  namespace :buildings do
    subscribe :create, 'ws_game_buildings#create'
  end
end

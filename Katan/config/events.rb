WebsocketRails::EventMap.describe do
  subscribe :chat, 'messages#new'
  subscribe :notice, 'messages#notice'
  namespace :buildings do
    subscribe :create, 'ws_game_buildings#create'
  end
end

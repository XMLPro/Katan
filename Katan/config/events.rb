WebsocketRails::EventMap.describe do
  subscribe :chat, 'messages#new'
  namespace :buildings do
    subscribe :create, 'ws_game_buildings#create'
  end
end

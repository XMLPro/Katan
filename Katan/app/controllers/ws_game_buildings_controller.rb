class WsGameBuildingsController < WebsocketRails::BaseController
  def create
    broadcast_message :notice, message
  end

  def update
    broadcast_message :notice, message
  end

  def destroy
    broadcast_message :notice, message
  end
end
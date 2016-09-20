class WsGameBuildingsController < WebsocketRails::BaseController
  def create
    if message[:result]
      broadcast_message :draw_building, message
    else
      send_message :notice, {result: :failed}
    end
  end

  def update
    broadcast_message :notice, message
  end

  def destroy
    broadcast_message :notice, message
  end
end
class ChatsController < ApplicationController
  def msg
    @msg = params[:msg]
  end
end

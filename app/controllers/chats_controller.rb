class ChatsController < ApplicationController
  ydef msg
    @msg = params[:msg]
  end
end

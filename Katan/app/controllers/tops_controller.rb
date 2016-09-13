class TopsController < ApplicationController
  def index
  	if User.count == 4
  		map_init
  	end
  end
end

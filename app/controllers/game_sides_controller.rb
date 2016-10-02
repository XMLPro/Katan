class GameSidesController < ApplicationController
  def index
    @side = GameSide.new
  end

  def all
    @sides = GameSide.all
  end

  def show
    @sides = GameSide.find params[:id]
  end

  def update
    side = GameSide.find_by id: params[:game_side][:id]
    @result = (side and side.update side_params) ? :success : :failed
  end

  def create
    side = GameSide.new side_params
    @result = side.save ? :success : :failed
  end

  def destroy
    side = GameSide.find_by id: params[:game_side][:id]
    if side
      side.destroy
      @result = :success
    else
      @result = :failed
    end
  end

  private
    def side_params
      params.require(:game_side).permit(:gamebuilding_id)
    end
end

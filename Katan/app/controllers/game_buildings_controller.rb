class GameBuildingsController < ApplicationController
  def index
    @building = GameBuilding.new
    @users = User.all
  end

  def all
    @buildings = GameBuilding.all
  end

  def show
    @building = GameBuilding.find params[:id]
  end

  def update
    building = GameBuilding.find_by id: params[:game_building][:id]
    @result = (building and building.update building_params) ? :success : :failed
  end

  def create
    build = GameBuilding.new building_params
    @result = build.save ? :success : :failed
  end

  def destroy
    building = GameBuilding.find_by id: params[:game_building][:id]
    if building
      building.destroy
      @result = :success
    else
      @result = :failed
    end
  end

  private
    def building_params
      params.require(:game_building).permit(:building_type, :user_id)
    end
end

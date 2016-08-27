class GameBuildingsController < ApplicationController
  def index
    @building = GameBuilding.new
  end

  def all
    @buildings = GameBuilding.all
  end

  def show
    @building = GameBuilding.find params[:id]
  end

  def update
    begin
      building = GameBuilding.find params[:game_building][:id]
      @result = building.update(building_params) ? :success : :failed
    rescue ActiveRecord::RecordNotFound
      @result = :failed
    end
  end

  def create
    build = GameBuilding.new building_params
    @result = build.save ? :success : :failed
  end

  def destroy
    begin
      building = GameBuilding.find params[:game_building][:id]
      building.destroy
      @result = :success
    rescue ActiveRecord::RecordNotFound
      @result = :failed
    end
  end

  private
    def building_params
      params.require(:game_building).permit(:building_type, :user_id)
    end
end

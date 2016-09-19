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
    if params[:intersection_id]
      intersection = GameIntersection.find_by id: params[:intersection_id]
      build = intersection.game_building || GameBuilding.new(building_params)
      build.building_type = BuildingType.find_by(
          name: build.building_type ? :special : :normal)
      @data = {place: :intersection}
      @data[:result] = if build.save
                         intersection.update game_building: build
                         @data[:position] = intersection.position
                         @data[:building_type] = build.building_type.name
                         true
                       else
                         false
                       end
    elsif params[:side_id]
      side = GameSide.find_by id: params[:side_id]
      unless side.game_building
        build = GameBuilding.new(building_params)
        build.building_type = BuildingType.find_by(name: :road)
        @data = {place: :side}
        @data[:result] = if build.save
                           side.update game_building: build
                           @data[:position] = side.position
                           @data[:building_type] = build.building_type.name
                           true
                         else
                           false
                         end
      end
    end
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
      # params[:user_id] = current_user
      # params.require(:game_building).permit(:user_id)
      {user: current_user}
    end
end

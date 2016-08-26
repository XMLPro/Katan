class BuildingsController < ApplicationController
  def index
    @buildings = GameBuilding.all
  end

  def new
    @building = GameBuilding.new
  end

  def show
    @building = GameBuilding.find params[:id]
  end

  def update
    @result = GameBuilding.update building_params ? @result = :success : @result = :failed
  end

  def create
    build = GameBuilding.new building_params
    @result = build.save ? :success : :failed
  end

  private
  def building_params
    params.require(:gameBuilding).permit(:building_type, :user_id)
  end
end

class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show]
  before_action :set_location, only:[:index]

  # GET /restaurants
  def index
    @restaurants = Restaurant.location_restaurants(@location, @search_terms="")
    logged_in_user
    render json: @restaurants
  end

  # GET /restaurants/1
  def show
    
    render json: @restaurant
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      #@restaurant = Restaurant.single("E8RJkjfdcwgtyoPMjQ_Olg")
      @restaurant = Restaurant.single(params[:id])
    end

    def set_location
      @location = "Ellijay GA"
      #@location = current_user.location
    end
end

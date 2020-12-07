class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show]
  before_action :set_location, only:[:index]

  
  def index
    @restaurants = Restaurant.location_restaurants(@location, @search_terms="")
    logged_in_user
    render json: @restaurants
  end

  
  def show    
    render json: @restaurant
  end

  private
    
    def set_restaurant      
      @restaurant = Restaurant.single(params[:id])
    end

    def set_location
      @location = logged_in_user.location      
    end
end

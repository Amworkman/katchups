class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show]
  before_action :set_location, only:[:index]

  
  def index    
    if params[:date]           
      @location = params[:location]
      @date = params[:date].to_time.to_i      
      @restaurants = Restaurant.location_restaurants(@location, @date)
      render json: @restaurants
    else
      @restaurants = Restaurant.location_restaurants(@location, @date="") 
      logged_in_user
      render json: @restaurants
    end
  end

  
  def show    
    render json: @restaurant
  end

  private
    
    def set_restaurant      
      @restaurant = Restaurant.single(params[:id])
    end

    def set_location 
        @location = params[:location]          
    end
end

class KatchupsController < ApplicationController
  before_action :set_katchup, only: [:show, :update, :destroy]
  
  def index
    @katchups = Katchup.where(user_id: logged_in_user.id).or(Katchup.where( friend_id: logged_in_user.id))
    render json: @katchups
  end
  
  def show    
    render json: @katchup
  end
  
  def create
    if  @relationship = Relationship.find_relationship(params["user_id"], params["friend_id"])
      @katchup = Katchup.new(katchup_params.merge(:relationship_id => @relationship))
      @location = params[:location]
      @date = params[:starts_at].to_time.to_i 
      @restaurants = [(Restaurant.katchup_restaurants(@location, @date, 0))["data"]["search"]["business"], (Restaurant.katchup_restaurants(@location, @date, 50))].flatten
      i = 10
      while i > 0
        num = rand(0..@restaurants.length-1)
        if !@katchup.katchup_array.include?(@restaurants[num])
          @katchup.katchup_array.push(@restaurants[num])
          i -= 1               
        end   
      end 
      if @katchup.save
        render json: @katchup, status: :created
      else
        render json: @katchup.errors, status: :unprocessable_entity
      end
    else
      render json: {
        error: "No such relationship"
      }
    end
  end
  
  def update
    if params[:user_restaurant]    
      @katchup.user_array.push(params[:user_restaurant])
    elsif params[:friend_restaurant]
      @katchup.friend_array.push(params[:friend_restaurant])
    end
    if @katchup.save
      render json: @katchup
    else 
      render json: @katchup.errors, status: :unprocessable_entity    
    end
  end
    
  def destroy
    @katchup.destroy
  end

  private
    
    def set_katchup
      @katchup = Katchup.find(params[:id])
    end
    
    def katchup_params
      params.permit(:relationsship, :restaurant_id, :user_confirmation, :friend_confirmation, :starts_at, :user_id, :friend_id,  :location, :user_array => [], :friend_array => [])
    end
end

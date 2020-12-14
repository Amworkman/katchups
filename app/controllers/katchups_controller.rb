class KatchupsController < ApplicationController
  before_action :set_katchup, only: [:show, :destroy]
  
  def index
    @katchups = Katchup.where(user_id: logged_in_user.id).or(Katchup.where( friend_id: logged_in_user.id))
    render json: @katchups
  end
  
  def show    
    render json: @katchup
  end
  
  def create
    @relationship = Relationship.find_relationship(params["user_id"], params["friend_id"])
      #if Katchup.detect
        @katchup = Katchup.new(katchup_params)
        @katchup.relationship_id = @relationship
    if @katchup.save
      render json: @katchup, status: :created, location: @katchup
    else
      render json: @katchup.errors, status: :unprocessable_entity
    end
  end
  
  def update     
    if params[:id]    
      @katchup = Katchup.find_by_id(params[:id]) 
      if @katchup.update(katchup_params)
        render json: @katchup
      else 
        render json: @katchup.errors, status: :unprocessable_entity
      end     
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

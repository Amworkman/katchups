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
    @relationship = Relationship.find_relationship(params["user_id"], params["friend_id"])
    @katchup = Katchup.where(relationship_id: @relationship)
     
    if params[:user_restaurant]
      @katchup.first.user_array << params[:user_restaurant]
    elsif params[:friend_restaurant]
      @katchup.first.friend_array << params[:friend_restaurant]
    end

    if @katchup.first.update(katchup_params)
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
      params.permit(:relationsship, :restaurant_id,:friend_id, :user_id, :user_array, :friend_array, :user_confimation, :friend_confimation, :starts_at, :location)
    end
end

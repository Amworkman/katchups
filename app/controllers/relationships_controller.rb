class RelationshipsController < ApplicationController
  before_action :set_relationship, only: [:show, :destroy]
  before_action :set_pending, only: [:update, :delete_pending]

  # GET /relationships
  def index
    @relationships = Relationship.all

    render json: @relationships
  end
  
  def show
    render json: @relationship
  end
  
  def create
    @relationship = Relationship.find_or_create_by(relationship_params)
    if @relationship.valid?
      render json: @relationship, status: :created, location: @relationship
    else
      render json: @relationship.errors, status: :unprocessable_entity
    end
  end
  
  def update
    @relationship = Relationship.where(friend_id: relationship_params[:user_id], user_id: relationship_params[:friend_id], confirmed: false)
    if @relationship.update(relationship_params)
      render json: @relationship
    else
      render json: @relationship.errors, status: :unprocessable_entity
    end
  end
 
  def destroy
    @relationship.destroy
  end

  def delete_pending
    @relationship.first.destroy
  end

  private
    
    def set_relationship
      @relationship = Relationship.find(params[:id])
    end
    
    def relationship_params
      params.permit(:user_id, :friend_id, :confirmed)
    end

    def set_pending
      @relationship = Relationship.where(friend_id: logged_in_user.id, confirmed: false)
    end
end

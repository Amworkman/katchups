class KatchupsController < ApplicationController
  before_action :set_katchup, only: [:show, :update, :destroy]
  
  def index
    @katchups = Katchup.all

    render json: @katchups
  end
  
  def show
    render json: @katchup
  end
  
  def create
    @katchup = Katchup.new(katchup_params)

    if @katchup.save
      render json: @katchup, status: :created, location: @katchup
    else
      render json: @katchup.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @katchup.update(katchup_params)
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
      params.require(:katchup).permit(:relationsship, :restaurant_id, :starts_at)
    end
end

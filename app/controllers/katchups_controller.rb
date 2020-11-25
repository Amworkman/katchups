class KatchupsController < ApplicationController
  before_action :set_katchup, only: [:show, :update, :destroy]

  # GET /katchups
  def index
    @katchups = Katchup.all

    render json: @katchups
  end

  # GET /katchups/1
  def show
    render json: @katchup
  end

  # POST /katchups
  def create
    @katchup = Katchup.new(katchup_params)

    if @katchup.save
      render json: @katchup, status: :created, location: @katchup
    else
      render json: @katchup.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /katchups/1
  def update
    if @katchup.update(katchup_params)
      render json: @katchup
    else
      render json: @katchup.errors, status: :unprocessable_entity
    end
  end

  # DELETE /katchups/1
  def destroy
    @katchup.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_katchup
      @katchup = Katchup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def katchup_params
      params.require(:katchup).permit(:relationsship, :restaurant_id, :starts_at)
    end
end

class UsersController < ApplicationController
  before_action :set_user, only: [:friends, :pending_friends, :show, :update, :destroy]
  before_action :authorized, only: [:auto_login]
  # GET /users
  def index
    @users = User.where("name ILIKE :search OR username ILIKE :search", search: "%#{params["search"]}%")
 
    render json: @users
  end
  
  def friends     
    @users = @user.friends      
    render json: @users
  end

  def pending_friends
    @users = @user.pending_friends
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create 
    @user = User.new(user_params)
    if @user.save
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    binding.pry
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  def auto_login
    render json: @user
  end


  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      logged_in_user
      @user = logged_in_user
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:username, :password, :email, :name, :location, :profile_img)
    end
end

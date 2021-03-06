class UsersController < ApplicationController
  before_action :set_user, only: [:friends, :pending_requests, :friend_requests, :show, :update, :destroy]
  before_action :authorized, only: [:auto_login]
  include Rails.application.routes.url_helpers
 
  def index
    @users = User.where("name ILIKE :search", search: "%#{params["search"]}%").with_attached_profile_img
    render json: @users.to_json(:include => [:relationships])
  end
  
  def friends     
    @users = @user.friends     
    render json: @users.as_json(root: "friend")
  end

  def friend_requests    
    @users = @user.friend_requests
    render json: @users.as_json(root: "request")
  end

  def pending_requests    
    @users = @user.pending_requests
    render json: @users.as_json(root: "pending")
  end
  
  def show
    render json: @user
  end
 
  def create 
    @user = User.new(user_params)    
    if @user.save
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end
  
  def update
    @user.profile_img.attach(data: params["profile_img"])
    if @user.update(user_params)
      @user.profile_img_url = url_for(@user.profile_img) 
      @user.save  
      respond_to_patch()
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login 
    @user = User.find_by(email: params[:email])
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
  
  def destroy
    @user.destroy
  end

  private

    def respond_to_patch()
      if @user.valid?()
        user_serializer = UserSerializer.new(user: @user)
        render json: user_serializer.serialize_updated_user()
      else
        render json: { errors: user.errors }, status: 400
      end
    end
    
    def set_user
      logged_in_user
      @user = logged_in_user
    end
    
    def user_params
      params.permit(:username, :password, :email, :name, :location, :profile_img_url)
    end
end

class UserSerializer

  def initialize(user:)
    @user = user
  end

  def serialize_updated_user()
    serialized_user = serialize_user(@user)
    serialized_user.to_json()
  end
  
  private def serialize_user(user)
     {
      user: {
        id: user.id,
        profile_img: user.get_image_url(),
        email: user.email,
        name: user.name,
        location: user.location,
        created_at: user.created_at
      }
    }
  end
  
end
  
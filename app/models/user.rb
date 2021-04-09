class User < ApplicationRecord
    include Rails.application.routes.url_helpers   
    has_secure_password
    has_many :relationships
    has_many :pending_relationships, -> { where confirmed: false }, class_name: 'Relationship', foreign_key: "friend_id"

    has_one_base64_attached :profile_img

    def get_image_url
        url_for(self.profile_img)
    end

    def friends
        sent_invitation = Relationship.where(user_id: id, confirmed: true).pluck(:friend_id)
        recieved_invitation = Relationship.where(friend_id: id, confirmed: true).pluck(:user_id)
        ids = sent_invitation + recieved_invitation
        User.where(id: ids)
    end

    def pending_requests
        sent_invitation = Relationship.where(user_id: id, confirmed: false).pluck(:friend_id)
        pending = sent_invitation
        User.where(id: pending)
    end

    def friend_requests
        recieved_invitation = Relationship.where(friend_id: id, confirmed: false).pluck(:user_id)
        request = recieved_invitation
        User.where(id: request)
    end

    def friend_with?(user)
        Relationship.confirmed_record?(id, user.id)
    end

    def send_invitation(user)
        Relationship.create(friend_id: user.id)
    end
end

class User < ApplicationRecord    
    has_secure_password
    has_many :relationships
    has_many :pending_relationships, -> { where confirmed: false }, class_name: 'Relationship', foreign_key: "friend_id"

    def friends
        friends_sent_invitation = Relationship.where(user_id: id, confirmed: true).pluck(:friend_id)
        friends_recieved_invitation = Relationship.where(friend_id: id, confirmed: true).pluck(:user_id)
        ids = friends_sent_invitation + friends_recieved_invitation
        User.where(id: ids)
    end

    def pending_friends
        friends_sent_invitation = Relationship.where(user_id: id, confirmed: false).pluck(:friend_id)
        friends_recieved_invitation = Relationship.where(friend_id: id, confirmed: false).pluck(:user_id)
        ids = friends_sent_invitation + friends_recieved_invitation
        User.where(id: ids)
    end

    def friend_with?(user)
        Relationship.confirmed_record?(id, user.id)
    end

    def send_invitation(user)
        Relationship.create(friend_id: user.id)
    end
end

class Relationship < ApplicationRecord
  belongs_to :user
  has_many :katchups

  def self.reacted?(id1, id2)
    case1 = !Relationship.where(user_id: id1, friend_id: id2).empty?
    case2 = !Relationship.where(user_id: id2, friend_id: id1).empty?
    case1 || case2
  end

  def self.confirmed_record?(id1, id2)
    case1 = !Relationship.where(user_id: id1, friend_id: id2, confirmed: true).empty?
    case2 = !Relationship.where(user_id: id2, friend_id: id1, confirmed: true).empty?
    case1 || case2
  end

  def self.find_relationship(id1, id2)
    if Relationship.where(user_id: id1, friend_id: id2, confirmed: true).empty?
      Relationship.where(user_id: id2, friend_id: id1, confirmed: true)[0].id
    else
      Relationship.where(user_id: id1, friend_id: id2, confirmed: true).id
    end
  end

  def self.pending_requests (id1, id2)
    Relationship.where(user_id: id1, friend_id: id2, confirmed: false)
  end

end

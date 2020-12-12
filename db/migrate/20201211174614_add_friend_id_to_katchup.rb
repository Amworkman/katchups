class AddFriendIdToKatchup < ActiveRecord::Migration[6.0]
  def change
    add_column :katchups, :friend_id, :integer
  end
end

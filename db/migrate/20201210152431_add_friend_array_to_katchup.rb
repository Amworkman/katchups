class AddFriendArrayToKatchup < ActiveRecord::Migration[6.0]
  def change
    add_column :katchups, :friend_array, :string, array: true, default: []
  end
end

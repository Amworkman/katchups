class AddFriendConfirmationToKatchup < ActiveRecord::Migration[6.0]
  def change
    add_column :katchups, :friend_confirmation, :boolean, default: false
  end
end

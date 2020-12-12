class AddUserIdToKatchup < ActiveRecord::Migration[6.0]
  def change
    add_column :katchups, :user_id, :integer
  end
end

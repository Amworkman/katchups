class AddUserConfirmationToKatchup < ActiveRecord::Migration[6.0]
  def change
    add_column :katchups, :user_confirmation, :boolean, default: false
  end
end

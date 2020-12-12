class AddUserArrayToKatchup < ActiveRecord::Migration[6.0]
  def change
    add_column :katchups, :user_array, :string, array: true, default: []
  end
end

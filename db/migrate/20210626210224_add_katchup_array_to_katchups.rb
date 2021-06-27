class AddKatchupArrayToKatchups < ActiveRecord::Migration[6.0]
  def change
    add_column :katchups, :katchup_array, :json, array: true, default: []
  end
end

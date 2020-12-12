class AddLocationToKatchup < ActiveRecord::Migration[6.0]
  def change
    add_column :katchups, :location, :string
  end
end

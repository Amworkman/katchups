class AddColumnToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :img, :string, :default => "No image available"
    add_column :restaurants, :menue, :string, :default => "No menue available"
  end
end

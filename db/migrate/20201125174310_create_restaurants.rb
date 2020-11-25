class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :description
      t.string :rating
      t.string :cuisine

      t.timestamps
    end
  end
end

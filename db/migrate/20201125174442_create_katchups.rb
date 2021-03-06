class CreateKatchups < ActiveRecord::Migration[6.0]
  def change
    create_table :katchups do |t|
      t.references :relationship, null: false, foreign_key: true
      t.string :restaurant_id
      t.datetime :starts_at
      t.boolean :confirmed, default: :false

      t.timestamps
    end
  end
end

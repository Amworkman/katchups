class CreateKatchups < ActiveRecord::Migration[6.0]
  def change
    create_table :katchups do |t|
      t.referances :relationship, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true
      t.datetime :starts_at

      t.timestamps
    end
  end
end

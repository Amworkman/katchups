class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.references :user, null: false, foreign_key: true
      t.friend_id :integer
      t.boolean :confirmed, default: :false

      t.timestamps
    end
  end
end

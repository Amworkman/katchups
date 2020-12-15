class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :password_digest
      t.string :email
      t.string :name
      t.string :location
      t.string :profile_img, default: "https://katchupsapi.herokuapp.com/images/katchup1.png"

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name, null: false
      t.string :username, null: false
      t.string :password_hash, null: false
      t.string :profile_pic_url, null: false
      t.string :email, null: false

      t.timestamps(null:false)
    end
  end
end
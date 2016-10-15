class CreateFriendLists < ActiveRecord::Migration
  def change
    create_table :friend_lists do |t|
      t.integer :user_id, null: false
      t.integer :friend_id, null: false

      t.timestamps(null: false)
    end
  end
end

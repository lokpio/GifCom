class CreateUsersChannels < ActiveRecord::Migration
  def change
        create_table :users_channels do |t|
      t.integer :user_id, null: false
      t.integer :channel_id, null: false

      t.timestamps(null:false)
    end
  end
end

class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name, null: false
      t.integer :creator_id, null: false

      t.timestamps(null: false)
    end
  end
end

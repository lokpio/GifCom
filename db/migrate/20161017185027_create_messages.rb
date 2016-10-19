class CreateMessages < ActiveRecord::Migration

  def change
  	create_table :messages do |t|
  		t.string :message
  		t.integer :channel_id, null:false
  		t.integer :writer_id, null:false

  		t.timestamps(null:false)
  	end
  end
end

class Message < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :chat
  belongs_to :writer, class_name: "User",foreign_key:"writer_id"
end

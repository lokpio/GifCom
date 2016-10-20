class UsersChannel < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  belongs_to :channel

  validates :user_id,uniqueness:{scope: :channel_id, message: "You have joined the table already."}
end

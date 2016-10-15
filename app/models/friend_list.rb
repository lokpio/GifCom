class FriendList < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :friend, class_name: "User", foreign_key: "friend_id"
  belongs_to :user
end

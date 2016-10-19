class Channel < ActiveRecord::Base
  # Remember to create a migration!
  has_many :users_channels
  has_many :users, through: :users_channels
  has_many :messages
  belongs_to :creator, class_name:"User"
end

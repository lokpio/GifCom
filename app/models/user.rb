require 'bcrypt'

class User < ActiveRecord::Base
  has_many :users_channels
  has_many :create_channels, foreign_key:"creator_id"
  has_many :sub_channels, through: :users_channels, source: :channel
    # users.password_hash in the database is a :string
  include BCrypt

	validates_presence_of :full_name
  validates_presence_of :username
  validates_presence_of :password
  validates_presence_of :email
  validates_uniqueness_of :email

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email,password)
    user = User.find_by(email: email.strip)
    if user && (user.password == password)
      return user
    end
      return nil
  end

end

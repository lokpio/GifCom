module SendBirdApi
  include HTTParty
  A_KEY = ENV['API_TOKEN']


  def self.find(user_id)
    HTTParty.get(
      "https://api.sendbird.com/v3/users/#{user_id}",
      headers: {"Api-Token": A_KEY} )
  end

  def self.create_user(user)
    HTTParty.post(
      "https://api.sendbird.com/v3/users/",
      body:{
        "user_id": "#{user.id}",
        "nickname": user.username,
        "profile_url": user.profile_pic_url
        }.to_json,
        headers: {"Api-Token": A_KEY}
        )
  end

  def self.create_channel(friend_list)
  #   HTTParty.post(
  #     "https://api.sendbird.com/v3/open_channels",
  #     body:{
  #       "name": "#{friend_list.friend.username}",         
  #       "cover_url": "#{friend_list.friend.profile_pic_url}",      
  #       "user_ids": ["#{friend_list.friend.id}","#{friend_list.user.id}"],
  #       "is_distinct": true
  #     }.to_json,
  #     headers: {"Api-Token": A_KEY}
  #     )
  end

  def self.send_message(channel,message,user_id)
    HTTParty.post(
      "https://api.sendbird.com/v3/open_channels/#{channel}/messages",
      body:{
        "message_type": "MESG",
        "user_id": "#{user_id}",
        "message": "#{message}",
        }.to_json,
        headers: {"Api-Token": A_KEY}
        )
  end
end

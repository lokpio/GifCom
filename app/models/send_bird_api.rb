module SendBirdApi
  include HTTParty
  A_KEY = ENV['API_TOKEN']


  def self.find(user_id)
    response = HTTParty.get(
      "https://api.sendbird.com/v3/users/#{user_id}",
      headers: {"Api-Token": A_KEY} )
    response
  end

  def self.create_user(user)
    HTTParty.post(
    "https://api.sendbird.com/v3/users/",
    body:{
    "user_id": "#{user.id}",
    "nickname": user.username,
    "profile_url": user.profile_pic_url
    }.to_json,
    headers: {"Api-Token": A_KEY})
  end
end

get '/token' do
  # Get the user-provided ID for the connecting device
  device_id = params['device']

  # Create a random username for the client
  identity = current_user.username

  # Create a unique ID for the currently connecting device
  endpoint_id = "TwilioDemoApp:#{identity}:#{device_id}"

  # Create an Access Token for IP messaging usage
  token = Twilio::Util::AccessToken.new ENV['TWILIO_ACCOUNT_SID'],
    ENV['TWILIO_API_KEY'], ENV['TWILIO_API_SECRET'], 3600, identity

  # Create IP Messaging grant for our token
  grant = Twilio::Util::AccessToken::IpMessagingGrant.new
  grant.service_sid = ENV['TWILIO_IPM_SERVICE_SID']
  grant.endpoint_id = endpoint_id
  token.add_grant grant

  # Generate the token and send to client
  # json :identity => identity, :token => token.to_jwt
  json identity: identity, token: token.to_jwt, channel: current_user
end

get "/chats/channel" do
  @channel = params[:channel]
  erb :"chats/show"
end
# #th routes needa change to :channel
# post "/chats/get_info" do
#   app_key = ENV['APP_KEY']
#   channel = params[:channel]
#   json app_key: app_key,channel:channel
# end

# get "/chats/channel" do

# 	# p params
# 	erb :"chats/show"
# end

# post "/chats/channel" do
# 	message = GifApi.gif_translate(params[:message])
#   user = PusherApi.create_client
# 	#the channel url and type need to be decide
# 	# response = SendBirdApi.send_message("sendbird_open_channel_9444_7fd8b2d74bd185f69b92f9f9a615cca2df68a2b7",message.parsed_response["data"]["images"]["original"]["url"],current_user.id)
# 	redirect :"/chats/channel"
# end

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

get "/chats" do
  @channel = params[:channel]
  erb :"chats/show"
end

post "/chats/message" do
  if params[:message].split(" ").length <= 4
    message = GifApi.gif_translate(params[:message]).parsed_response["data"]["images"]["fixed_width_downsampled"]["url"]
  else
    message = params[:message]
  end
  json message: message
end


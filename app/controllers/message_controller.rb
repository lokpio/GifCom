#th routes needa change to :channel
post "/chats/get_info" do
  app_key = ENV['APP_KEY']
  channel = params[:channel]
  json app_key: app_key,channel:channel
end

get "/chats/channel" do

	# p params
	erb :"chats/show"
end

post "/chats/channel" do
	message = GifApi.gif_translate(params[:message])
  user = PusherApi.create_client
	#the channel url and type need to be decide
	# response = SendBirdApi.send_message("sendbird_open_channel_9444_7fd8b2d74bd185f69b92f9f9a615cca2df68a2b7",message.parsed_response["data"]["images"]["original"]["url"],current_user.id)
	redirect :"/chats/channel"
end

#th routes needa change to :channel

get "/chats/channel" do

	# p params
	erb :"chats/show"
end

post "/chats/channel" do
	message = GifApi.gif_translate(params[:message])
	#the channel url and type need to be decide
	response = SendBirdApi.send_message("sendbird_open_channel_9444_7fd8b2d74bd185f69b92f9f9a615cca2df68a2b7",message.parsed_response["data"]["images"]["original"]["url"],current_user.id)
	redirect :"/chats/channel"
end
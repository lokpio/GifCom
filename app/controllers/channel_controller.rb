

get '/channels' do
  @user = current_user
  erb :"channels/index"
end

get "/channels/new" do
  erb :"channels/new"
end

post "/channels" do
  channel = Channel.new(name:params[:name],creator_id: current_user.id)
  if channel.save
    subscribe = UsersChannel.new(user_id:current_user.id,channel_id:channel.id)
    if subscribe.save
      redirect :"/channels"
    end
      redirect :"/channels"
  end
end

get "/channels/find" do
  @channels = Channel.where(name: params[:name])
  p "%"*30
  p @channels
  erb :"channels/show"
end

post "/channels/join" do
  subscribe = UsersChannel.new(user_id:current_user.id,channel_id:params[:sub_channel])
  if subscribe.save
    redirect :"/channels"
  end
    redirect :"/channels"
end
# post "/friends/:id" do
#   @user = User.find(params[:id])
#   # @user_in_sendbird = SendBirdApi.find(@user.id).parsed_response
#   erb :"friends/show"
# end

# post "/friends" do
#   friend = Chat.new(friend_id: params[:friend_id],user_id: current_user.id )
#   if friend.save
#     redirect "/friends"
#   else
#     redirect "/friends/new"
#   end
# end

# post "/friends/:id/chat" do
#   # friend_list = FriendList.find(params[:id])
#   # channel = SendBirdApi.create_channel(friend_list)
#   # channel_url = channel.parsed_response["channel_url"]
#   # redirect "/chats/#{channel_url}"
# end

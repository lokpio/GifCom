

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
    else
      @errors = subscribe.errors.messages
      erb :"channels/new"
    end
    redirect :"/channels"
  else
    @errors = channel.errors.messages
    erb :"channels/new"
  end
end

get "/channels/find" do
  @channel = Channel.find_by(name: params[:name])
  if @channel
    erb :"channels/show"
  else
    @errors = {error:["Channel does not exist."]}
    erb :"channels/index"
  end
end

post "/channels/:id/join" do
  subscribe = UsersChannel.new(user_id:current_user.id,channel_id:params[:id])
  if subscribe.save
    redirect :"/channels"
  else
    @channel = Channel.find(params[:id])
    @errors = subscribe.errors.messages
    erb :"channels/show"
  end
end

delete "/channels/:id" do
  channel = Channel.find(params[:id])
  channel.destroy
  redirect "/channels"
end

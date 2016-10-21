get '/channels' do
  erb :"channels/index"
end

get "/channels/new" do
  if request.xhr?
    erb :"channels/new",layout: false
  else
    erb :"channels/new"
  end
end

post "/channels" do
  channel = Channel.new(name:params[:name],creator_id: current_user.id)
  if channel.save
    subscribe = UsersChannel.new(user_id:current_user.id,channel_id:channel.id)
    if subscribe.save
      if request.xhr?
        erb :"partials/_channel",layout:false,locals:{channel:channel}
      else
        redirect :"/channels"
      end
    else
      @errors = subscribe.errors.messages
      if request.xhr?
       page = erb :"partials/_error",layout:false, locals:{errors: @errors}
       error = true
       json page:page, error:error
     else
      erb :"channels/new"
    end
  end
else
  @errors = channel.errors.messages

  if request.xhr?
    page = erb :"partials/_error",layout:false, locals:{errors: @errors}
    error = true
    json page:page, error:error
  else
    erb :"channels/new"
  end
end
end

get "/channels/find" do
  @channel = Channel.find_by(name: params[:name])
  if @channel
    if request.xhr?
      erb :"channels/show", layout:false
    else
      erb :"channels/show"
    end
  else
    @errors = {error:["Channel does not exist."]}
    if request.xhr?
      erb :"channels/show", layout:false
    else
      erb :"channels/index"
    end
  end
end

post "/channels/:id/join" do
  subscribe = UsersChannel.new(user_id:current_user.id,channel_id:params[:id])
  if subscribe.save
    redirect :"/channels"
  else
    @channel = Channel.find(params[:id])
    @errors = subscribe.errors.messages
    if request.xhr?
      erb :"partials/_error",layout:false, locals:{errors: @errors}
    else
    erb :"channels/show"
  end
  end
end

delete "/channels/:id" do
  channel = Channel.find(params[:id])
  channel.destroy
  if request.xhr?
    json id: params[:id]
  else
    redirect "/channels"
  end
end

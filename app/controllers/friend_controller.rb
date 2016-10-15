require 'net/http'

get '/friends' do
  @user = current_user

  erb :"friends/index"
end

get "/friends/new" do
  erb :"friends/new"
end

post "/friends" do
  friend = FriendList.new(friend_id: params[:friend_id],user_id: current_user.id )
  if friend.save
    redirect "/friends"
  else
    redirect "/friends/new"
  end
end

post "/friends/find" do
  user = User.find_by(email: params[:email])
  redirect "/friends/#{user.id}"
end

get "/friends/:id" do
  @user = User.find(params[:id])
  erb :"friends/show"
end

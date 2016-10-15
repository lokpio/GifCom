# #find friends
# get'/users' do
#   erb :"users/index"
# end
#reg new users
get '/users/new' do
  erb :"users/new"
end

post '/users' do
  user = User.new(params[:user])
  if user.save

    redirect "/login"
  else
    redirect "/users/new"
  end
end




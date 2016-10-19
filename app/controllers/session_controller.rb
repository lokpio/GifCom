get '/login' do
  erb :"sessions/new"
end

post '/login' do
  user = User.authenticate(params[:email],params[:password])
  if (!logged_in?) && (user!=nil)
    login(user)
    redirect "/channels"
  else
    redirect :"/users/new"
  end
end

get '/logout' do
  logout
  redirect "/"
end

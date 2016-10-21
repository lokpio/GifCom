get '/login' do
  if request.xhr?
    page = erb :"partials/_login",layout: false
  else
    erb :"sessions/new"
  end
end

post '/login' do
  user = User.authenticate(params[:email],params[:password])
  if (!logged_in?) && (user!=nil)
    login(user)
    redirect "/channels"
  else
    @errors = {message:["Account does not exist"]}
    redirect :"/users/new"
  end
end

get '/logout' do
  logout
  redirect "/"
end

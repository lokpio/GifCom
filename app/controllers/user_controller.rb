# #find friends
# get'/users' do
#   erb :"users/index"
# end
#reg new users
get '/users/new' do
	erb :"users/new"
end

post '/users' do
	if params[:user][:password] == params[:password_confirmation]
		user = User.new(params[:user])
		if user.save
			SendBirdApi.create_user(user)
			redirect "/login"
		else
			@errors = user.errors.messages
			p @errors
			erb :"users/new"
		end
	else
		@errors = {password: ["Confirm password is not the same"]}
		erb :"users/new"
	end
end




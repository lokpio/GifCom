# #find friends
# get'/users' do
#   erb :"users/index"
# end
#reg new users
get '/users/new' do
	if request.xhr?
		erb :"partials/_register",layout: false
	else
		erb :"users/new"
	end
end

post '/users' do
	if params[:user][:password] == params[:password_confirmation]
		user = User.new(params[:user])
		if user.save
			login(user)
			redirect "/channels"
		else
			@errors = user.errors.messages
			erb :"users/new"
		end
	else
		@errors = {password: ["Confirm password is not the same"]}
		erb :"users/new"
	end
end




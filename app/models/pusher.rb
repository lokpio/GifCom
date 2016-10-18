module PusherApi
	def create_client
		Pusher::Client.new(
			app_id: ENV["API_ID"],
			key: ENV["API_KEY"],
			secret: ENV["API_SECRET"],
			encrypted: true
			)
	end

	def send_meg(client)
		pusher_client.trigger('test_channel', 'my_event', {
  		message: 'hello world'
		})
	end
end
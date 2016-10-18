# module TwilioApi

# 	def self.get_token
# 		if current_user
# 			# Create a unique ID for the currently connecting device
# 			endpoint_id = "Chat:#{current_user.email}:browser"
# 	  		# Create an Access Token for IP messaging usage
# 	  		token = Twilio::Util::AccessToken.new ENV['TWILIO_ACCOUNT_SID'],
# 	  		ENV['TWILIO_API_KEY'], ENV['TWILIO_API_SECRET'], 3600, current_user.email	
#   		end	
# 	end

# 	def self.get_grant	
# 		# Create IP Messaging grant for our token
# 		grant = Twilio::Util::AccessToken::IpMessagingGrant.new
# 		grant.service_sid = ENV['TWILIO_IPM_SERVICE_SID']
# 		grant.endpoint_id = endpoint_id
# 		grant
# 	end
# end
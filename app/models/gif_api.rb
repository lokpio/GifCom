module GifApi
	include HTTParty

	def self.gif_translate(message)
		HTTParty.get(
			"http://api.giphy.com/v1/gifs/translate?s=#{message}&api_key=dc6zaTOxFJmzC")
	end
end

  # @gif = GifApi.gif_translate("fuck").parsed_response["data"]["images"]["original"]["url"]
    # <img src="<%= @gif %>">
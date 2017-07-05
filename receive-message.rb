require 'net/http'
require 'json'
require 'base64'

### Listening for messages on channel 'mychannel'
uri = URI('http://localhost:5001/api/v0/pubsub/sub?arg=mychannel')
Net::HTTP.start(uri.host, uri.port) do |http|
	request = Net::HTTP::Get.new uri

	http.request request do |response|
		response.read_body do |chunk|
			msg = JSON.parse(chunk)
			if msg != {}
				data = Base64.decode64(msg["data"])
				from = Base64.decode64(msg["from"])

				puts "Got message: #{data}"
				# Curreny msg.from is a bit incorrect, but will be contained PeerID
				puts "From: #{from}"
			end
		end
	end
end

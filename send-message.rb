require 'net/http'

uri = URI('http://localhost:5001/api/v0/pubsub/pub?arg=mychannel&arg=mymessage')
Net::HTTP.start(uri.host, uri.port) do |http|
	request = Net::HTTP::Get.new uri
	http.request request
end
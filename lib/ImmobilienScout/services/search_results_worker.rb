require 'celluloid/autostart'
require 'net/http'
require 'uri'
require 'json'

module ImmobilienScout
	class SearchResultsWorker
		include Celluloid
		include Celluloid::Notifications

		def fetch_results(url:, callback:)
			uri = URI.parse url
			response = Net::HTTP.get_response(uri)

			if response.code.to_i != 200
				callback.call(false, nil)
			else
				decoded_json = JSON.parse(response.body)
				next_page = deserialize_next_page(decoded_json)
				listings = deserialize_listings(decoded_json)
				
				callback.call(self, true, listings, next_page)
			end
		end

		def deserialize_next_page(json)
			return 'https://www.immobilienscout24.de' + json['nextPage'] if json['nextPage']
		end

		def deserialize_listings(json)
			json['searchResult']['results']
		end
	end
end
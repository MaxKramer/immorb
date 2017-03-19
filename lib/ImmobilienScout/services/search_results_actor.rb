require 'celluloid/autostart'
require 'net/http'
require 'uri'
require 'json'

module ImmobilienScout
	class SearchResultsActor
		include Celluloid

		def fetch_result(url:)
			begin
				uri = URI.parse url
				response = Net::HTTP.get_response(uri)
			rescue
				raise ImmobilienScout::Errors::Execute::InvalidUri, url
			end

			if response.code.to_i != 200
				nil
			else
				begin 
					decoded_json = JSON.parse(response.body)
				rescue
					raise ImmobilienScout::Errors::Execute::InvalidResponseBody, response.body
				end
				next_page = deserialize_next_page(decoded_json)
				listings = deserialize_listings(decoded_json)
				
				SearchResult.new(listings: listings, next_page: next_page)
			end
		end

		def deserialize_next_page(json)
			next_page = json['nextPage']
			"https://www.immobilienscout24.de#{next_page}" unless next_page.nil?
		end

		def deserialize_listings(json)
			json['searchResult']['results']
		end
	end
end
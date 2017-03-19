module ImmobilienScout
	class Client
		attr_reader :search_urls

		def initialize(search_urls:)
			@search_urls = search_urls
		end

		def execute
			raise Errors::Execute::NoUrlsProvided if @search_urls.count == 0

			coordinator = SearchResultsCoordinator.new(search_urls: @search_urls) 
			coordinator.execute
		end
	end
end
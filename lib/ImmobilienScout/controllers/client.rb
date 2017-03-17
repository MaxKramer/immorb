module ImmobilienScout
	class Client
		attr_accessor :search_urls
		attr_accessor :slack_service

		def initialize(search_urls:)
			@search_urls = search_urls
		end

		def execute
			raise Errors::Execute::NoUrlsProvided if @search_urls.count == 0

			coordinator = SearchResultsCoordinator.new(search_urls: @search_urls) 
			new_listings = coordinator.execute

			post_to_slack new_listings if new_listings.count > 0
		end

		def post_to_slack(listings)
			@slack_service ||= SlackService.new
			@slack_service.post listings
		end
	end
end
module ImmobilienScout
	class Client
		attr_accessor :search_urls
		def initialize(search_urls:)
			@search_urls = search_urls
			@database = Database.new
			@database.connect
		end

		def execute
			raise Errors::Execute::NoUrlsProvided if @search_urls.count == 0

			coordinator = SearchResultsCoordinator.new(search_urls: @search_urls)
			new_listings = coordinator.execute

			post_to_slack new_listings
		end

		def post_to_slack(listings)
			channel = ENV.fetch 'SLACK_CHANNEL'
			webhookurl = ENV.fetch 'SLACK_HOOK_URL'
			username = ENV.fetch 'SLACK_USERNAME'
			slack_service = SlackService.new(webhookurl: webhookurl, channel: channel, username: username)

			slack_service.post(listings) if listings.count > 0
		end
	end
end
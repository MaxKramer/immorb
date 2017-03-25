require 'celluloid/current'

module ImmobilienScout
	class SearchResultsCoordinator
		include Celluloid

		attr_accessor :search_urls
		attr_accessor :actor_pool
		attr_accessor :listings

		def initialize(search_urls:)
			@search_urls = search_urls
			@actor_pool = ImmobilienScout::SearchResultsActor.pool(size: @search_urls.count)
			@listings = []
		end

		def execute
			@search_urls.each do |url|
				results = search_results_for url
				parse_results results
			end
			@listings
		end

		def search_results_for(url)
			results = []
			last_result = @actor_pool.future.fetch_result(url: url).value
			results << last_result unless last_result.nil?

			if last_result.nil? || last_result.next_page.nil?
			else
				next_results = search_results_for(last_result.next_page)
				results.push(*next_results)
			end

			results
		end

		def parse_results(results)
			results.each do |result|
				@listings.push(*result.listings) if result.listings.count > 0
			end
		end
	end
end	
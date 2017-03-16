require 'celluloid/autostart'

module ImmobilienScout
	class SearchResultsCoordinator
		include Celluloid

		attr_accessor :search_urls
		attr_accessor :finished_condition

		attr_accessor :number_of_workers
		attr_accessor :finished_workers
		attr_accessor :listings

		def initialize(search_urls:)
			@search_urls = search_urls
			@listings = []
			@number_of_workers = search_urls.count
			@finished_workers = 0
			@finished_condition = Celluloid::Condition.new
		end

		def execute
			search_pool = ImmobilienScout::SearchResultsWorker.pool(size: @search_urls.count)
			callback_block = lambda do |actor, result, fetched_listings, next_page|
				@finished_workers += 1

				@listings.push(*fetched_listings) if result == true

				if next_page
					@number_of_workers += 1
					search_pool.async.fetch_results(url: next_page, callback: callback_block)
				end

				if @finished_workers == @number_of_workers
					@finished_condition.signal
				end
			end

			@search_urls.each do |url|
				search_pool.async.fetch_results(url: url, callback: callback_block)
			end

			finished_condition.wait
			insert_new_listings @listings
		end

		def insert_new_listings(listings)
			inserted_listings = []
			existing_ids = Listing.all.pluck(:id)
			listings.each do |listing|
				unless existing_ids.include? listing['id'].to_i
					obj = Listing.create
					obj.fill_from listing
					obj.save!

					existing_ids.push obj.id
					inserted_listings.push obj
				end
			end
			inserted_listings
		end
	end
end	
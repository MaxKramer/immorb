module ImmobilienScout
	class SearchResult
		attr_accessor :listings
		attr_accessor :next_page

		def initialize(listings:, next_page:)
			@listings = listings
			@next_page = next_page
		end
	end
end
require 'spec_helper'

describe ImmobilienScout::SearchResultsCoordinator do
	def search_urls 
		%w(http://localhost http://localhosts http://localhostss)
	end

	def subject
		ImmobilienScout::SearchResultsCoordinator.new(search_urls: search_urls)
	end

	describe 'initialize' do
		it 'stores the search urls' do
			subj = subject
			expect(subj.search_urls).to eq(search_urls)
			expect(subj.search_urls.count).to eq(search_urls.count)
		end

		it 'initialises listings as an empty array' do
			expect(subject.listings).to_not be_nil
		end

		it 'creates a actor pool sized at the number of search urls' do
			subj = subject
			expect(subj.actor_pool).to_not be_nil
			expect(subj.actor_pool.size).to eq(search_urls.count)
		end
	end

	describe 'execute' do
		it 'gets the search results for each search url' do
			subj = subject.wrapped_object
			subj.search_urls.each do |url|
				expect(subj).to receive(:search_results_for).with(url)
			end
			expect(subj).to receive(:parse_results).exactly(subj.search_urls.count).times
			result = subj.execute
			expect(result).to be_kind_of(Array)
		end

		it 'returns the correct number of listings' do
			fake_results = [
				ImmobilienScout::SearchResult.new(listings: ['foo', 'bar'], next_page: nil),
				ImmobilienScout::SearchResult.new(listings: [], next_page: nil),
				ImmobilienScout::SearchResult.new(listings: ['foo', 'bar', 'baz'], next_page: nil)
			]

			subj = subject

			fake_results.each_with_index do |result, idx|
				expect(subj.actor_pool.wrapped_object).to receive(:fetch_result).with(url: search_urls[idx]).and_return(result)				
			end

			listings = subj.execute
			expect(listings.count).to eq(5)
		end
	end

	describe 'parse_results' do
		it 'goes through each of the results and adds them to the listings if count > 0' do
			subj = subject
			expect(subj.listings.count).to eq(0)

			fake_results = [
				ImmobilienScout::SearchResult.new(listings: ['foo', 'bar'], next_page: nil),
				ImmobilienScout::SearchResult.new(listings: [], next_page: nil),
				ImmobilienScout::SearchResult.new(listings: ['foo', 'bar', 'baz'], next_page: 'http://localhost')
			]

			subj.parse_results fake_results
			expect(subj.listings.count).to eq(5)
		end
	end

	describe 'search_results_for' do
		it 'fetches results for given url' do
			subj = subject
			url = search_urls.first
			expect(subj.actor_pool.wrapped_object).to receive(:fetch_result).with(url: url)
			results = subj.search_results_for url
			expect(results).to be_kind_of(Array)
		end

		it 'recurses over results if next_page is not nil' do
			subj = subject
			url = search_urls.first

			recursive_result = ImmobilienScout::SearchResult.new(listings: ['foo', 'bar'], next_page: search_urls[1])
			stubbed_result	 = ImmobilienScout::SearchResult.new(listings: ['foo', 'bar', 'baz'], next_page: nil)

			expect(subj.actor_pool.wrapped_object).to receive(:fetch_result).with(url: url).and_return(recursive_result)
			expect(subj.actor_pool.wrapped_object).to receive(:fetch_result).with(url: recursive_result.next_page).and_return(stubbed_result)

			results = subj.search_results_for url
			expect(results.count).to eq(2)
			expect(results.first.listings.count).to eq(2)
			expect(results[1].listings.count).to eq(3)
		end

		it 'only stores results that arent nil' do
			subj = subject
			url = search_urls.first

			expect(subj.actor_pool.wrapped_object).to receive(:fetch_result).with(url: url).and_return(nil)
			results = subj.search_results_for url
			expect(results.count).to eq(0)
		end
	end
end
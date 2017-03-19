require 'spec_helper'

describe ImmobilienScout::Client do
	describe 'initialise' do
		it 'stores the supplied search urls' do
			search_urls = [ 'localhost' ]

			client = ImmobilienScout::Client.new(search_urls: search_urls)
			expect(client.search_urls).to eq(search_urls)
			expect(client.search_urls.count).to eq(1)
		end
	end

	describe 'execute' do
		it 'throws an exception if no search urls were provided' do
			client = ImmobilienScout::Client.new(search_urls: [])
			expect do
				client.execute
			end.to raise_exception(ImmobilienScout::Errors::Execute::NoUrlsProvided)
		end

		it 'retrieves listings from a search results coordinator' do
			search_urls = ['http://google.com']
			client = ImmobilienScout::Client.new(search_urls: search_urls)

			results = ['']
			expect_any_instance_of(ImmobilienScout::SearchResultsCoordinator).to receive(:execute).and_return(results)

			expect(client.execute.count).to eq(1)
		end
	end
end
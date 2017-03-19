require 'spec_helper'

describe ImmobilienScout::SearchResultsActor do

	def subject
		ImmobilienScout::SearchResultsActor.new		
	end

	describe 'fetch_result' do
		it 'throws an exception if it cant parse the uri' do
			invalid_url = 'ü'
			expect do
				subject.fetch_result(url: invalid_url)
			end.to raise_exception(ImmobilienScout::Errors::Execute::InvalidUri)
		end

		it 'returns nil with non 200 response code' do
			stub_request(:get, 'localhost').to_return(status: 400)
			expect(subject.fetch_result(url: 'http://localhost')).to be_nil
		end

		it 'throws an exception if it cannot decode the response body' do
			stub_request(:get, 'localhost').to_return(body: '{]}')
			expect do
				subject.fetch_result(url: 'http://localhost')
			end.to raise_exception(ImmobilienScout::Errors::Execute::InvalidResponseBody)
		end

		it 'returns a search result with listings and next page' do
			stub_request(:get, 'localhost').to_return(body: File.read('spec/fixtures/listings.json'))
			result = subject.fetch_result(url: 'http://localhost')
			expect(result.listings.count).to eq(10)
			expect(result.next_page).to eq('https://www.immobilienscout24.de/foobarbaz')
		end
	end

	describe 'deserialize_next_page' do
		it 'returns nil if theres no next page' do
			next_page = subject.deserialize_next_page JSON.parse('{}')
			expect(next_page).to be_nil
		end

		it 'returns nil if theres no next page' do
			json_hash = '{ "nextPage" : "/foobar" }'
			next_page = subject.deserialize_next_page JSON.parse(json_hash)
			expect(next_page).to eq('https://www.immobilienscout24.de/foobar')
		end		
	end

	describe 'deserialize_listings' do
		it 'returns the searchResult.results' do
			json = JSON.parse(File.read('spec/fixtures/listings.json'))
			listings = subject.deserialize_listings json
			expect(listings.count).to eq(10)
		end

		it 'returns nil if there are no results' do
			json = JSON.parse(File.read('spec/fixtures/no_results.json'))
			listings = subject.deserialize_listings json
			expect(listings).to be_nil
		end
	end
end
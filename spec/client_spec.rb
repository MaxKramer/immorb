require 'spec_helper'

describe ImmobilienScout::Client do
	describe 'execute' do
		it 'throws an exception if no urls were provided' do
			client = ImmobilienScout::Client.new(search_urls: [])
			expect do
				client.execute
			end.to raise_exception(ImmobilienScout::Errors::Execute::NoUrlsProvided)
		end

		it 'retrieves listings from a search results coordinator and posts them to slack' do
			search_urls = ['http://google.com']
			client = ImmobilienScout::Client.new(search_urls: search_urls)

			slack_helper = double('SlackHelper')

			results = ['']
			expect_any_instance_of(ImmobilienScout::SearchResultsCoordinator).to receive(:execute).and_return(results)
			expect_any_instance_of(ImmobilienScout::SlackService).to receive(:post).with(results)

			client.execute
		end
	end

	describe 'post_to_slack' do
		it 'posts to slack if listings are greater than 0' do
			search_urls = ['']
			listings = [ImmobilienScout::Listing.create]
			client = ImmobilienScout::Client.new(search_urls: search_urls)
			expect_any_instance_of(ImmobilienScout::SlackService).to receive(:post).with(listings)
			client.post_to_slack listings
		end

		it 'doesnt post to slack if there are no new listings' do
			search_urls = ['']
			client = ImmobilienScout::Client.new(search_urls: search_urls)
			expect_any_instance_of(ImmobilienScout::SlackService).to_not receive(:post)
			client.post_to_slack []
		end
	end
end
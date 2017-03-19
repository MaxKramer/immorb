require 'spec_helper'

describe ImmobilienScout::SearchResult do
	describe 'initialize' do
		def subject 
			ImmobilienScout::SearchResult.new(listings: ['foo', 'bar', 'baz'], next_page: 'foobar')
		end

		it 'stores the listings' do
			expect(subject.listings).to eq(['foo', 'bar', 'baz'])
		end

		it 'stores the next page' do
			expect(subject.next_page).to eq('foobar')
		end
	end
end
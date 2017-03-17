require "spec_helper"

describe ImmobilienScout::Errors do 
	describe 'execute' do
		it 'has a no urls provided error' do
			expect(ImmobilienScout::Errors::Execute::NoUrlsProvided.ancestors.include? ImmobilienScout::Errors::ImmobilienScoutError).to be_truthy 
		end

		it 'has a request failed error' do
			expect(ImmobilienScout::Errors::Execute::RequestFailed.ancestors.include? ImmobilienScout::Errors::ImmobilienScoutError).to be_truthy 
		end

		it 'has an immobilientscout base class' do
			expect(ImmobilienScout::Errors::ImmobilienScoutError).to_not be_nil
		end
	end
end
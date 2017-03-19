require "spec_helper"

describe ImmobilienScout::Errors do 
	describe 'execute' do
		it 'has a no urls provided error' do
			expect(ImmobilienScout::Errors::Execute::NoUrlsProvided.ancestors.include? ImmobilienScout::Errors::ImmobilienScoutError).to be_truthy 

			error = ImmobilienScout::Errors::Execute::NoUrlsProvided.new
			expect(error.message).to_not be_nil
		end

		it 'has a request failed error' do
			expect(ImmobilienScout::Errors::Execute::RequestFailed.ancestors.include? ImmobilienScout::Errors::ImmobilienScoutError).to be_truthy 
			
			error = ImmobilienScout::Errors::Execute::RequestFailed.new
			expect(error.message).to_not be_nil
		end

		it 'has a invalid uri error' do
			expect(ImmobilienScout::Errors::Execute::InvalidUri.ancestors.include? ImmobilienScout::Errors::ImmobilienScoutError).to be_truthy 
			
			error = ImmobilienScout::Errors::Execute::InvalidUri.new
			expect(error.message).to_not be_nil
		end

		it 'has a invalid response body error' do
			expect(ImmobilienScout::Errors::Execute::InvalidResponseBody.ancestors.include? ImmobilienScout::Errors::ImmobilienScoutError).to be_truthy 
			
			error = ImmobilienScout::Errors::Execute::InvalidResponseBody.new
			expect(error.message).to_not be_nil
		end

		it 'has an immobilientscout base class' do
			expect(ImmobilienScout::Errors::ImmobilienScoutError).to_not be_nil
			
			error = ImmobilienScout::Errors::ImmobilienScoutError.new
			expect(error.message).to_not be_nil
		end
	end
end
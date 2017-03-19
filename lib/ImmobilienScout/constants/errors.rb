module ImmobilienScout
	module Errors
		class ImmobilienScoutError < StandardError
			def message
				'Something went wrong'
			end
		end
		
		module Execute
			class NoUrlsProvided < ImmobilienScoutError
				def message
					'You must provide at least one url'
				end
			end
			class RequestFailed < ImmobilienScoutError
				def message
					'The request failed'
				end
			end

			class InvalidUri < ImmobilienScoutError
				def message
					'Invalid uri for one of the search urls'
				end
			end

			class InvalidResponseBody < ImmobilienScoutError
				def message
					'Response body was invalid json'
				end
			end
		end
	end
end
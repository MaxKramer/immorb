module ImmobilienScout
	module Errors
		class ImmobilienScoutError < StandardError; end
		module Execute
			class NoUrlsProvided < ImmobilienScoutError; end
			class RequestFailed < ImmobilienScoutError; end
		end
	end
end
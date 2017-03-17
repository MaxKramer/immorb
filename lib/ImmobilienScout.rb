require 'ImmobilienScout/version'

# Models
require 'ImmobilienScout/models/listing'
require 'ImmobilienScout/models/attribute'
require 'ImmobilienScout/models/configuration'

# Controllers
require 'ImmobilienScout/controllers/client'
require 'ImmobilienScout/controllers/search_results_coordinator'

# Services
require 'ImmobilienScout/services/slack_service'
require 'ImmobilienScout/services/search_results_worker'

# Constants
require 'ImmobilienScout/constants/errors'

module ImmobilienScout
	class << self
		attr_accessor :configuration
	end

	def self.configure(&obj)
		obj.call(configuration)
	end

	private
	def self.configuration
		@configuration ||= Configuration.new
	end
end

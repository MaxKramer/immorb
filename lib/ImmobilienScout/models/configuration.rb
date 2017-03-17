module ImmobilienScout
	class Configuration
		# Database
		attr_accessor :database_host
		attr_accessor :database_name
		attr_accessor :database_username
		attr_accessor :database_password
		
		# Slack
		attr_accessor :slack_channel
		attr_accessor :slack_hook_url
		attr_accessor :slack_username

		def initialize
			@database_host = ENV['DATABASE_HOST']
			@database_name = ENV['DATABASE_NAME']
			@database_username = ENV['DATABASE_USER']
			@database_password = ENV['DATABASE_PASSWORD']

			@slack_channel = ENV['SLACK_CHANNEL']
			@slack_hook_url = ENV['SLACK_HOOK_URL']
			@slack_username = ENV['SLACK_USERNAME']
		end
	end
end
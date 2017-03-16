require 'active_record'

module ImmobilienScout
	class Database
		def connect
			conn = ActiveRecord::Base.establish_connection(
			  adapter:  'postgresql',
			  host:     ENV.fetch('DATABASE_HOST'),
			  database: ENV.fetch('DATABASE_NAME'),
			  username: ENV.fetch('DATABASE_USER'),
			  password: ENV.fetch('DATABASE_PASSWORD'),
			  pool: 10
			)

			if !Listing.table_exists? 
				create_schema
			end
			conn
		end

		private
		def create_schema
			ActiveRecord::Schema.define do 
				create_table :listings do |t|
					t.timestamps
				end
			end
		end
	end
end
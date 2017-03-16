require 'active_record'

module ImmobilienScout
	class Listing < ActiveRecord::Base
		attr_accessor :title
		attr_accessor :address
		attr_accessor :district
		attr_accessor :city
		attr_accessor :zip
		attr_accessor :photo_urls
		attr_accessor :distance
		attr_accessor :company_logo
		attr_accessor :company_name
		attr_accessor :contact_name
		attr_accessor :external_attributes
		attr_accessor :additional_properties
		attr_accessor :latitude
		attr_accessor :longitude

		def fill_from(result)
			self.id = result['id'].to_i
			
			@title = result['title']
			@address = result['address']
			@district = result['district']
			@city = result['city']
			@zip = result['zip']

			media_count = result['mediaCount']
			galleryPictures = result['galleryPictures']

			if media_count > 0
				@photo_urls = galleryPictures.map do |picture|
					picture['url']
				end
			end

			@distance = result['distanceInKm']
			@company_logo = result['realtorLogoForResultlistUrl']
			@company_name = result['realtorCompanyName']
			@contact_name = result['contactName']
			@external_attributes = result['attributes'].map do |attr|
				Attribute.new(title: attr['title'], value: attr['value'])
			end
			@additional_properties = result['checkedAttributes']
			@latitude = result['latitude']
			@longitude = result['longitude']
		end
	end
end
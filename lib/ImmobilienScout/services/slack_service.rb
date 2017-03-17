require 'slack-notifier'

module ImmobilienScout
	class SlackService
		attr_accessor :notifier
		def initialize

			@notifier = Slack::Notifier.new ImmobilienScout.configuration.slack_hook_url do
				defaults channel: ImmobilienScout.configuration.slack_channel,
				username: ImmobilienScout.configuration.slack_username
			end
		end

		def post(listings)
			attachments = listings.map do |listing|
				author_name = listing.company_name || listing.contact_name
				image_url = listing.photo_urls.first unless listing.photo_urls.nil?
				attachment = {
					"fallback" => listing.title,
					"author_name" => author_name,
					"author_link" => "https://www.immobilienscout24.de/expose/#{listing.id}#/basicContact/email",
					"author_icon" => listing.company_logo,
					"title" => listing.title,
					"title_link" => "https://www.immobilienscout24.de/expose/#{listing.id}",
					"text" => "#{listing.distance.round(2)} km: #{listing.address}, #{listing.zip}\n\nExtras:\n-#{listing.additional_properties.join("\n-")}",
					"image_url" => image_url
				}

				fields = listing.external_attributes.map do |attr|
					{
						title: attr.title,
						value: attr.value
					}
				end

				attachment["fields"] = fields
				attachment
			end

			@notifier.post text: "Found #{listings.count} new listing#{listings.count == 1 ? '' : 's' }", attachments: attachments
		end
	end
end
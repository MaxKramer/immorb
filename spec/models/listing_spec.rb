require 'spec_helper'

describe ImmobilienScout::Listing do
	describe 'fill_from' do
		def fixture
			@parsed_json ||= JSON.parse(File.read('spec/fixtures/listing.json'))
		end

		def subject
			listing = ImmobilienScout::Listing.new
			listing.fill_from fixture
			listing
		end

		it 'parses the id correctly' do
			expect(subject.id).to eq(93815596)
		end

		it 'parses the title correctly' do
			expect(subject.title).to eq('title')
		end

		it 'parses the address correctly' do
			expect(subject.address).to eq('address')
		end

		it 'parses the district correctly' do
			expect(subject.district).to eq('district')
		end

		it 'parses the city correctly' do
			expect(subject.city).to eq('city')
		end

		it 'parses the zip correctly' do
			expect(subject.zip).to eq('zip')
		end

		it 'parses the photo_urls correctly' do
			photo_urls = [
				'https://pic.immobilienscout24.de/pic/orig01/N/564/104/212/564104212-0.jpg/ORIG/legacy_thumbnail/420x315/format/jpg/quality/80',
				'https://pic.immobilienscout24.de/pic/orig03/N/564/104/214/564104214-0.jpg/ORIG/legacy_thumbnail/420x315/format/jpg/quality/80'
			]
			expect(subject.photo_urls).to eq(photo_urls)
		end

		it 'parses the distance correctly' do
			expect(subject.distance).to eq(1)
		end

		it 'parses the company logo correctly' do
			expect(subject.company_logo).to eq('company_logo')
		end

		it 'parses the contact name correctly' do
			expect(subject.contact_name).to eq('contact_name')
		end

		it 'parses the external attributes correctly' do
			titles = %w(Kaltmiete Wohnfläche Zimmer)
			values = ['1 €', '49 m²', '2']

			expect(subject.external_attributes.count).to eq(3)
			expect(subject.external_attributes.map(&:title)).to eq(titles)
			expect(subject.external_attributes.map(&:value)).to eq(values)
		end

		it 'parses the additional properties correctly' do
			values = %w(Balkon/Terrasse Einbauküche Keller)
			expect(subject.additional_properties).to eq(values)
		end

		it 'parses the latitude correctly' do
			expect(subject.latitude).to eq(52.5)
		end

		it 'parses the longitude correctly' do
			expect(subject.longitude).to eq(13.4)
		end
	end
end
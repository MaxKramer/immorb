require 'spec_helper'

describe ImmobilienScout::Attribute do
	describe 'initializer' do
		it 'stores the title' do
			attr = ImmobilienScout::Attribute.new(title: 'title', value: 'value')
			expect(attr.title).to eq('title')
		end

		it 'stores the value' do
			attr = ImmobilienScout::Attribute.new(title: 'title', value: 'value')
			expect(attr.value).to eq('value')
		end
	end
end
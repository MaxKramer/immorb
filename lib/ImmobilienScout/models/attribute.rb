module ImmobilienScout
	class Attribute
		attr_accessor :title
		attr_accessor :value

		def initialize(title:, value:)
			@title = title
			@value = value
		end
	end
end
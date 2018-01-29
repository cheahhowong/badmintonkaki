class Event < ApplicationRecord
	has_many :relationships, dependent: :destroy
  	has_many :users, through: :relationships

  	def full_street_address
 		[address,postcode,city,state].compact.join(',')
	end

  	geocoded_by :full_street_address
	after_validation :geocode
end

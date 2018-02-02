class Event < ApplicationRecord
	has_many :relationships, dependent: :destroy
  	has_many :users, through: :relationships

  	validates_presence_of :start_date, :start_time, :end_time, :address, :state, :city, :postcode

  	def full_street_address
 		[address,postcode,city,state].compact.join(',')
	end

	def self.search (params)
		results = Event.all
		
		results = results.where("state LIKE ?", "%#{params[:state]}%") if params[:state].present?
		results = results.where("city LIKE ?", params[:city]) if params[:city].present?
		results = results.where("start_date LIKE ?", params[:start_date]) if params[:start_date].present?
		results = results.where("start_time LIKE ?", params[:start_time]) if params[:start_time].present?
		results = results.where("end_time LIKE ?", params[:end_time]) if params[:end_time].present?

		return results
	end

  	geocoded_by :full_street_address
	after_validation :geocode
end

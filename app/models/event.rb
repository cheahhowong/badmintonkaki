class Event < ApplicationRecord
	has_many :relationships, dependent: :destroy
  	has_many :users, through: :relationships
end

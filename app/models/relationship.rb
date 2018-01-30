class Relationship < ApplicationRecord
    enum status: { participant: 0, host: 1}
    belongs_to :user, inverse_of: :relationships
    belongs_to :event, inverse_of: :relationships
    
end

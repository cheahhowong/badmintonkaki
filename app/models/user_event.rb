class UserEvent < ApplicationRecord
	enum status: { participant: 0, host: 1}

end

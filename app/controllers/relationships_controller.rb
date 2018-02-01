class RelationshipsController < ApplicationController

	def create
		@relationship = Relationship.new(relationship_params)
		if @relationship.save
			redirect_to user_path(current_user.id)
		else
			redirect_to root_path
		end 
	end

end

private

def relationship_params
	params.require(:relationship).permit(:user_id,:event_id)
end

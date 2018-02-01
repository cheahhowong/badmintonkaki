class RelationshipsController < ApplicationController

	def create
		@relationship = Relationship.new(relationship_params)
		@event = Event.find_by(id: params[:relationship][:event_id])
		if @relationship.save
		@name = current_user.first_name
		@participant = @event.relationships.count
			render json: {saved: true, count: @participant, username: @name}
		else
			redirect_to root_path
		end 
	end

end

private

def relationship_params
	params.require(:relationship).permit(:user_id,:event_id)
end

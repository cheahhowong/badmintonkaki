class EventsController < ApplicationController

	def create
		@new_event = current_user.events.build(event_params)
		if @new_event.save
			redirect_to "/"
		else

		end
	end

	def show
		@event = Event.find_by(id: params[:id])
		@participant = @event.relationships
		@hash = Gmaps4rails.build_markers(@event) do |job, marker|
            marker.lat job.latitude
            marker.lng job.longitude
        end
	end

	def edit
    	@event = Event.find_by(id: params[:id])
    end

    def update
    	@event = Event.find_by(id: params[:id])
    	@event.update(event_params)
    	redirect_to event_path(params[:id])
    end

    def destroy
    	@event = Event.find_by(id: params[:id])
    	@event.destroy
    	redirect_to user_path(current_user.id)
    end

end

private
def event_params
	params.require(:event).permit(:title,:description,:start_date,:start_time,:end_time,:address,:city,:postcode,:state,:latitude,:longitude)
end
class TicketTypesController < ApplicationController
	def new
		@event = Event.find(params[:event_id])
    	@ticket_type = @event.ticket_types.new
	end

	def create
		@event = Event.find(params[:event_id])
	    @ticket_type = @event.ticket_types.new(ticket_type_params)
	    if @ticket_type.save
	      redirect_to new_event_ticket_type_path(@event), flash: {success: 'Ticket type has been created successfully!'}
	    else
	      flash.now[:error] = @ticket_type.full_messages.to_sentence
	      render 'new'
	    end
	end

	private
    def ticket_type_params
      params.require(:ticket_type).permit(:name, :price, :max_quantity)
    end
end

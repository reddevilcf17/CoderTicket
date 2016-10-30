class TicketOrdersController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @ticket_order = Ticket.new
    @event.ticket_types.each do |ticket_type|
      order_detail = @ticket_order.ticket_details.build
      order_detail.ticket_type = ticket_type
      order_detail.quantity = 0
    end
  end

  def create
  	puts ticket_order_params.inspect

  	out_of_stock = false
    @event = Event.find(params[:event_id])
    @ticket_order = Ticket.new(ticket_order_params)
    @ticket_order.total_amount = 0
    @ticket_order.ticket_details.each do |td|
      ticket_type = TicketType.find(td.ticket_type_id)
      out_of_stock = true if ticket_type.max_quantity < td.quantity
      @ticket_order.total_amount += td.quantity * ticket_type.price
    end
    if out_of_stock
      flash[:error] = "Ticket out of quantity!"
      redirect_to :back
    else
      if @ticket_order.save
        @ticket_order.ticket_details.each do |td|
          ticket_type = TicketType.find(td.ticket_type_id)
          ticket_type.max_quantity = ticket_type.max_quantity - td.quantity
          ticket_type.save
        end
        redirect_to event_path(@event), flash: {success: 'Your order has been successfully created. Please go to our office within 24h for confirmation and payment!'}
      else
        flash[:error] = "Cannot order tickets for some reasons"
        redirect_to :back
      end
    end

  end

	private
	def ticket_order_params
	params.require(:ticket).permit(:event_id, ticket_details_attributes: [:ticket_type_id, :quantity])
	end
end

class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @ticket_order = Ticket.new
    # @event.ticket_types.each do |ticket_type|
    #   order_detail = @ticket_order.ticket_details.build
    #   order_detail.ticket_type = ticket_type
    #   order_detail.quantity = 0
    # end
  end

  def create
  	puts params[:tickets].inspect
  	raise 'abc'
  end
end

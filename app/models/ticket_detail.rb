class TicketDetail < ApplicationRecord
  belongs_to :ticket
  belongs_to :ticket_type
end

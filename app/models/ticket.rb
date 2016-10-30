class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :ticket_details

  accepts_nested_attributes_for :ticket_details
end

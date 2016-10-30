class Venue < ActiveRecord::Base
  belongs_to :region
  has_one :event
  # validates_uniqueness_of :name
end

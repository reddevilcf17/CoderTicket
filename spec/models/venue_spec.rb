require 'rails_helper'

RSpec.describe Venue, type: :model do
	describe "name" do
		it "should be unique" do
			venue1 = Venue.new(name: 'New World Hotel')
			venue2 = Venue.new(name: 'Rex Holtel')
			venue3 = Venue.new(name: 'Rex Holtel')
			expect(venue1.save).to be_truthy
			expect(venue2.save).to be_truthy
			venue3.save
			expect(venue3.errors[:name]).to_not be_empty
		end
	end
end

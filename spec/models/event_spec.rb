require 'rails_helper'

RSpec.describe Event, type: :model do

	before do
		@category = FactoryGirl.create(:category, name:'Entertainment')
	end

	describe "validations" do
		it "checks for presence of extended_html_description" do
			venue = FactoryGirl.create(:venue)
			
			event = Event.new(venue: venue, category: @category, starts_at: Time.now)
			event.save
			expect(event.errors[:extended_html_description]).to_not be_empty 
			event.extended_html_description = '<h1>A certain event</h1>'
			expect(event.save).to be_truthy
		end

		it "checks for presence of venue" do

			event = Event.new(extended_html_description: '<h1>A certain event</h1>', category: @category, starts_at: Time.now)
			event.save
			expect(event.errors[:venue]).to_not be_empty			
			event.venue = FactoryGirl.create(:venue)
			expect(event.save).to be_truthy
		end

		it "checks for presence of category" do
			venue = FactoryGirl.create(:venue)
			event = Event.new(extended_html_description: '<h1>A certain event</h1>', venue: venue, starts_at: Time.now)
			event.save
			expect(event.errors[:category]).to_not be_empty
			event.category = @category
			expect(event.save).to be_truthy
		end

		it "checks for presence of starts_at" do
			venue = FactoryGirl.create(:venue)

			event = Event.new(extended_html_description: '<h1>A certain event</h1>',venue: venue, category: @category)
			event.save
			expect(event.errors[:starts_at]).to_not be_empty 
			event.starts_at = Time.now			
			expect(event.save).to be_truthy
		end

		it "checks for name should be uniqueness in scope of venue and starts_at" do
			venue = FactoryGirl.create(:venue)
			starts_at = Time.now

			event1 = Event.new(extended_html_description: '<h1>A certain event</h1>',venue: venue, category: @category, starts_at: starts_at)
			event2 = Event.new(extended_html_description: '<h1>A certain event</h1>',venue: venue, category: @category, starts_at: starts_at)
			event1.name = 'event'
			event2.name = 'event'
			expect(event1.save).to be_truthy
			event2.save
			expect(event2.errors[:name].to_sentence).to eq 'has already been taken'
			event2.name = 'event1'
			expect(event2.save).to be_truthy
		end

		# it "checks for duplicate name when not in scope of venue and starts_at" do
		# 	venue1 = FactoryGirl.create(:venue, name: 'venue1')
		# 	venue2 = FactoryGirl.create(:venue, name: 'venue2')

		# 	starts_at1 = Time.now
		# 	starts_at2 = Time.now + (2*7*24*60*60)

		# 	event1 = Event.new(extended_html_description: '<h1>A certain event</h1>',venue: venue1, category: @category, starts_at: starts_at1)
		# 	event2 = Event.new(extended_html_description: '<h1>A certain event</h1>',venue: venue2, category: @category, starts_at: starts_at2)
		# 	event1.name = 'event'
		# 	event2.name = 'event'
		# 	expect(event1.save).to be_truthy
		# 	event2.save
		# 	expect(event2.errors[:name].to_sentence).to be_empty
			
		# 	# event2.name = 'event1'
		# 	# expect(event2.save).to be_truthy
		# end

	end
end

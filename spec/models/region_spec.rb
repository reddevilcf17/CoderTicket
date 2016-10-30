require 'rails_helper'

RSpec.describe Region, type: :model do
	describe "name" do
		it "should be in the list" do
			region1 = Region.new(name: 'Ho Chi Minh')
			region2 = Region.new(name: 'Ha Noi')
			region3 = Region.new(name: 'Binh Thuan')
			region4 = Region.new(name: 'Da Nang')
			region5 = Region.new(name: 'Lam Dong')

			expect(region1.save).to be_truthy
			expect(region2.save).to be_truthy
			expect(region3.save).to be_truthy
			expect(region4.save).to be_truthy
			expect(region5.save).to be_truthy

			region6 = Region.new(name: 'Hoi An')
			region6.save
			expect(region6.errors[:name]).to_not be_empty

		end
		it "duplicates" do 
			region = Region.new(name: 'Ho Chi Minh')
			region1 = Region.new(name: 'Ho Chi Minh')
			expect(region.save).to be_truthy
			region1.save
			expect(region1.errors[:name]).to_not be_empty
		end
	end

end

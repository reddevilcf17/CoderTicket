require 'rails_helper'

RSpec.describe Category, type: :model do
	describe "validations" do
		it "checks for presence of name" do
			category = Category.new
			category.save
			expect(category.errors[:name]).to_not be_empty

		end

		it "checks for name should be in the list" do
			category = Category.new(name: 'Entertainment')
			expect(category.save).to be_truthy
			category1 = Category.new(name: 'Learning')
			expect(category1.save).to be_truthy
			category2 = Category.new(name: 'Everything Else')
			expect(category1.save).to be_truthy

			category3 = Category.new(name: 'Everything')
			category3.save
			expect(category3.errors[:name]).to_not be_empty
		end
	end
end

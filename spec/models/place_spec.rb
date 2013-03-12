# == Schema Information
#
# Table name: places
#
#  id         :integer          not null, primary key
#  city       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Place do
	before do
		@place = FactoryGirl.create(:place)
		@service = FactoryGirl.create(:service, place_id: @place.id)
	end

	subject{ @place }

	it { should respond_to :id }	
	it { should respond_to :created_at }	
	it { should respond_to :updated_at }	
	it { should respond_to :city}

	it { should_not allow_mass_assignment_of :id }
	it { should_not allow_mass_assignment_of :created_at }
	it { should_not allow_mass_assignment_of :updated_at }
	it { should allow_mass_assignment_of :city }

	it { should have_many :services }

	it "is invalid when city is null" do
		FactoryGirl.build(:place, city: nil).should_not be_valid
	end

	it "should destroy associated services" do 
		@place.destroy 
		[@service].each do |service| 
			lambda do
				Service.find(service) 
			end.should raise_error(ActiveRecord::RecordNotFound) 
		end 
	end
end

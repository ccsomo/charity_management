# == Schema Information
#
# Table name: group_services
#
#  id             :integer          not null, primary key
#  group_id       :integer          not null
#  service_id     :integer          not null
#  members_served :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe GroupService do
	before do
		@place = FactoryGirl.create(:place)
		@group = FactoryGirl.create(:group)
		@service = FactoryGirl.create(:service, place_id: @place.id)
		@group_service = GroupService.create(group_id: @group.id, service_id: @service.id, members_served: 4) 
	end

	subject{ @group_service }

	it { should respond_to :id }	
	it { should respond_to :group_id }	
	it { should respond_to :service_id }	
	it { should respond_to :members_served}
	it { should respond_to :created_at }	
	it { should respond_to :updated_at }	

	it { should_not allow_mass_assignment_of :id }
	it { should_not allow_mass_assignment_of :created_at }
	it { should_not allow_mass_assignment_of :updated_at }
	it { should allow_mass_assignment_of :group_id }
	it { should allow_mass_assignment_of :service_id }
	it { should allow_mass_assignment_of :members_served }

	it { should belong_to :group }
	it { should belong_to :service }


	it "is invalid when group_id is null" do
		@group_service.group_id = nil
		@group_service.should_not be_valid
	end

	it "is invalid when service_id is null" do
		@group_service.service_id = nil
		@group_service.should_not be_valid

	end

	it "is invalid when members_served is null" do
		@group_service.members_served = nil
		@group_service.should_not be_valid

	end
end

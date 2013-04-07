# == Schema Information
#
# Table name: services
#
#  id                :integer          not null, primary key
#  date              :date             not null
#  place_id          :integer          not null
#  description       :string(255)      not null
#  notes             :text
#  hours             :integer          not null
#  sent_survey       :boolean          default(FALSE)
#  returned_survey   :boolean          default(FALSE)
#  trained           :boolean          default(FALSE)
#  willing_to_return :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Service do
	before(:all) do
		@place = FactoryGirl.create(:place)
		@group = FactoryGirl.create(:group)
	end

	before(:each) do
    @place.services.create(FactoryGirl.attributes_for(:service))
    @service = @place.services.first
		GroupService.create(service_id: @service.id, group_id: @group.id, members_served: 4)	  
	end

	subject{ @service }

	it { should respond_to :id }	
	it { should respond_to :created_at }	
	it { should respond_to :updated_at }	
	it { should respond_to :date }	
	it { should respond_to :place_id }	
	it { should respond_to :description}
	it { should respond_to :notes}
	it { should respond_to :hours}
	it { should respond_to :sent_survey}
	it { should respond_to :returned_survey}
	it { should respond_to :trained}
	it { should respond_to :willing_to_return}
	it { should respond_to :group_services}
	it { should respond_to :people}
	it { should respond_to :place}
	it { should respond_to :groups}
	it { should respond_to :in_kind_donation}

	it { should_not allow_mass_assignment_of :id }
	it { should_not allow_mass_assignment_of :created_at }
	it { should_not allow_mass_assignment_of :updated_at }
	it { should allow_mass_assignment_of :date }
	it { should allow_mass_assignment_of :place_id }
	it { should allow_mass_assignment_of :description }
	it { should allow_mass_assignment_of :notes }
	it { should allow_mass_assignment_of :hours }
	it { should allow_mass_assignment_of :sent_survey }
	it { should allow_mass_assignment_of :returned_survey }
	it { should allow_mass_assignment_of :trained }
	it { should allow_mass_assignment_of :willing_to_return }

	it { should have_and_belong_to_many :people }
	it { should have_many :group_services }
	it { should have_many :groups }
	it { should belong_to :place }
	it { should have_one :in_kind_donation }

	it "is invalid when date is null" do
		@service.date = nil
		@service.should_not be_valid
	end

	it "is invalid when place_id is null" do
		@service.place_id = nil
		@service.should_not be_valid
	end

	it "is invalid when hours is null" do
		@service.hours = nil
		@service.should_not be_valid
	end

	it "is invalid when description is null" do
		@service.description = nil
		@service.should_not be_valid
	end

	it "should destroy associated group_services" do 
		@service.destroy 
		[@group_service].each do |group_service| 
			lambda do
				GroupService.find(group_service) 
			end.should raise_error(ActiveRecord::RecordNotFound) 
		end 
	end

	it "should destroy associated in_kind_donation" do 
		@service.create_in_kind_donation(FactoryGirl.attributes_for(:in_kind_donation))
		@in_kind_donation = @service.in_kind_donation
		@service.destroy
		lambda { InKindDonation.find(@in_kind_donation) }.should raise_error(ActiveRecord::RecordNotFound)
	end
end

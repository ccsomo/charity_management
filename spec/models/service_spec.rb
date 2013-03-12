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
	before do
		@place = FactoryGirl.create(:place)
		@group = FactoryGirl.create(:group)
		@service = FactoryGirl.create(:service, place_id: @place.id)
		@group_service = FactoryGirl.create(:group_service, group_id: @group.id, service_id: @service.id) 
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
		FactoryGirl.build(:service, date: nil).should_not be_valid
	end

	it "is invalid when place_id is null" do
		FactoryGirl.build(:service, place_id: nil).should_not be_valid
	end

	it "is invalid when hours is null" do
		FactoryGirl.build(:service, hours: nil).should_not be_valid
	end

	it "should destroy associated group_services" do 
		@service.destroy 
		[@group_service].each do |group_service| 
			lambda do
				GroupService.find(group_service) 
			end.should raise_error(ActiveRecord::RecordNotFound) 
		end 
	end

	pending "should destroy associated in_kind_donation", focus: true do 
		in_kind_donation = FactoryGirl.create(:in_kind_donation, service_id: @service.id)
		p InKindDonation.count
		p in_kind_donation
		p InKindDonation.find(in_kind_donation)
		@service.destroy 
		[in_kind_donation].each do |ikd| 
			lambda do
				InKindDonation.find(ikd) 
			end.should raise_error(ActiveRecord::RecordNotFound) 
		end 
	end
end

# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  members    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Group do
	before { @group = FactoryGirl.create(:group) }

	subject{ @group }

	it { should respond_to :id }	
	it { should respond_to :name }	
	it { should respond_to :members }	
	it { should respond_to :created_at }	
	it { should respond_to :updated_at }	

  it { should_not allow_mass_assignment_of :id }
  it { should_not allow_mass_assignment_of :created_at }
  it { should_not allow_mass_assignment_of :updated_at }
  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :members }

  it { should have_many :group_services }
  it { should have_many :services }
  it { should have_many :cash_donations }
  it { should have_and_belong_to_many :people}


	it "is invalid when name is null" do
		FactoryGirl.build(:group, name: nil).should_not be_valid
	end

	it "should destroy associated group_services" do 
			place = FactoryGirl.create(:place)
			service = FactoryGirl.create(:service, place_id: place.id)
			group_services = FactoryGirl.create(:group_service, service_id: service.id, group_id: @group.id)
			@group.destroy 
			[group_services].each do |group_service| 
				lambda do
					GroupService.find(group_service) 
				end.should raise_error(ActiveRecord::RecordNotFound) 
			end 
		end

	it "should destroy associated cash_donations" do 
		cash_donations = @group.cash_donations.create(FactoryGirl.attributes_for(:cash_donation))
		@group.destroy 
		[cash_donations].each do |cash_donation| 
			lambda do
				CashDonation.find(cash_donation) 
			end.should raise_error(ActiveRecord::RecordNotFound) 
		end 
	end
end

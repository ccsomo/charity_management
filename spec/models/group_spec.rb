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

end

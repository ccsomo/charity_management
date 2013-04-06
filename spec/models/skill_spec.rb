# == Schema Information
#
# Table name: skills
#
#  id          :integer          not null, primary key
#  description :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Skill do
	before {@skill = FactoryGirl.create(:skill)}	

	subject{ @skill}

	it { should respond_to :id }	
	it { should respond_to :created_at }	
	it { should respond_to :updated_at }
  it { should_not allow_mass_assignment_of :id }
  it { should_not allow_mass_assignment_of :created_at }
  it { should_not allow_mass_assignment_of :updated_at }
	it { should respond_to :description}
	it { should allow_mass_assignment_of :description}

	it "is invalid when decription is null" do
		FactoryGirl.build(:skill, description: nil).should_not be_valid
	end
end

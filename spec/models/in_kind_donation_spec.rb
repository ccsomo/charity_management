# == Schema Information
#
# Table name: donations
#
#  id           :integer          not null, primary key
#  date         :date             not null
#  type         :string(255)
#  group_id     :integer
#  person_id    :integer
#  service_id   :integer
#  amount       :integer
#  dollar_value :integer
#  description  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe InKindDonation do
  before(:all) do
    @person = FactoryGirl.create(:person)
    @place = FactoryGirl.create(:place)
    @place.services.create(FactoryGirl.attributes_for(:service))
    @service = @place.services.first
    @person.services << @service
  end

  before(:each) do
    @service.create_in_kind_donation(FactoryGirl.attributes_for(:in_kind_donation))
    @donation = @service.in_kind_donation
  end

  describe "date" do
    it "is a valid attribute" do
      @donation.should respond_to :date
    end

    it "is an accessible attribute" do
      @donation.should allow_mass_assignment_of :date
    end

    it "is present" do
      @donation.date = ''
      @donation.should_not be_valid
    end
  end

  describe "description" do
    it "is a valid attribute" do
      @donation.should respond_to :description
    end

    it "is an accessible attribute" do
      @donation.should allow_mass_assignment_of :description
    end

    it "is present" do
      @donation.description = nil
      @donation.should_not be_valid
    end
  end

  describe "dollar_value" do
    it "is a valid attribute" do
      @donation.should respond_to :dollar_value
    end

    it "is an accessible attribute" do
      @donation.should allow_mass_assignment_of :dollar_value
    end

    it "is present" do
      @donation.dollar_value = nil
      @donation.should_not be_valid
    end
  end

  describe "services associations" do
    it "should have a service attribute" do
      @donation.should respond_to :service
    end

    it "should refer to the correct service" do
      @donation.service.should eq @service
    end
  end
end

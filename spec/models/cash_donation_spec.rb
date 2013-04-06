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

describe CashDonation do
  before(:all) do
    @person = FactoryGirl.create(:person)
    @person.cash_donations.create(FactoryGirl.attributes_for(:cash_donation))
  end
  
  before(:each) do
    @donation = @person.cash_donations.first
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

  describe "amount" do
    it "is a valid attribute" do
      @donation.should respond_to :amount
    end

    it "is an accessible attribute" do
      @donation.should allow_mass_assignment_of :amount
    end

    it "is present" do
      @donation.amount = nil
      @donation.should_not be_valid
    end
  end

  describe "people associations" do
    it "should have a person attribute" do
      @donation.should respond_to :person
    end

    it "should refer to the correct person" do
      @donation.person.should eq @person
    end
  end

  describe "groups associations" do
    before(:each) do
      @group = FactoryGirl.create(:group)
      @group.cash_donations.create(FactoryGirl.attributes_for(:cash_donation))
      @donation = @group.cash_donations.first
    end

    it "should have a group attribute" do
      @donation.should respond_to :group
    end

    it "should refer to the correct group" do
      @donation.group.should eq @group
    end

    it "should destroy associated cash_donations" do 
      @donations = @group.cash_donations
      @group.destroy 
      @donations.each do |donation| 
        lambda do
          CashDonation.find(donation) 
        end.should raise_error(ActiveRecord::RecordNotFound) 
      end 
    end
  end
end

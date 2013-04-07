# == Schema Information
#
# Table name: people
#
#  id                :integer          not null, primary key
#  first_name        :string(255)
#  last_name         :string(255)
#  representative_id :integer
#  email             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Person do
  before(:each) do
    @person = FactoryGirl.create(:person)
  end

  describe "name" do
    it "is an attribute for a person" do
      @person.should respond_to :name
    end

    it "is an accessible attribute for a person" do
      @person.should allow_mass_assignment_of :name
    end
  end

  describe "email" do
    it "is an attribute for a person" do
      @person.should respond_to :email
    end

    it "is an accessible attribute for a person" do
      @person.should allow_mass_assignment_of :email
    end

    it "has a valid format" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        @person.email = address
        @person.should be_valid
      end
    end

    it "does not have an invalid format" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        @person.email = address
        @person.should_not be_valid
      end
    end

    it "can be nil" do
      @person.name = "David Hahn"
      @person.email = nil
      @person.should be_valid
    end
  end

  it "should have email or name present" do
    @person.name = nil
    @person.email = nil
    @person.should_not be_valid
  end

  describe "city" do
    it "is an attribute for a person" do
      @person.should respond_to :city
    end

    it "is an accessible attribute for a person" do
      @person.should allow_mass_assignment_of :city
    end
  end

  describe "street" do
    it "is an attribute for a person" do
      @person.should respond_to :street
    end

    it "is an accessible attribute for a person" do
      @person.should allow_mass_assignment_of :street
    end
  end
  describe "state" do
    it "is an attribute for a person" do
      @person.should respond_to :state
    end

    it "is an accessible attribute for a person" do
      @person.should allow_mass_assignment_of :state
    end
  end
  describe "zip" do
    it "is an attribute for a person" do
      @person.should respond_to :zip
    end

    it "is an accessible attribute for a person" do
      @person.should allow_mass_assignment_of :zip
    end
  end

  describe "representative associations" do
    before(:each) do
      @rep = FactoryGirl.create(:person)
      @person = FactoryGirl.create(:person, representative: @rep)
      @represented = FactoryGirl.create(:person, representative: @person)
    end

    it "should have a representative attribute" do
      @person.should respond_to :representative
    end

    it "should have a represents attribute" do
      @person.should respond_to :represents
    end

    it "should assign in the right order" do
      @person.representative.should eq @rep
      @person.represents.should eq [@represented]
    end

    it "should nullify deleted associations" do
      @rep.destroy
      @person.reload
      @person.representative.should be_nil
      @represented.destroy
      @person.reload
      @person.represents.should eq []
    end
  end

  describe "groups associations" do
    before(:each) do
      @group = FactoryGirl.create(:group)
    end

    it "should have a groups attribute" do
      @person.should respond_to :groups
    end

    it "should refer to the correct groups" do
      @person.groups << @group
      @person.groups.should eq [@group]
    end
  end

  describe "skills associations" do
    before(:each) do
      @skill = FactoryGirl.create(:skill)
    end

    it "should have a skills attribute" do
      @person.should respond_to :skills
    end

    it "should refer to the correct skills" do
      @person.skills << @skill
      @person.skills.should eq [@skill]
    end
  end

  describe "services associations" do
    before(:each) do
      @place = FactoryGirl.create(:place)
      @service = FactoryGirl.create(:service, place: @place) 
    end

    it "should have a services attribute" do
      @person.should respond_to :services
    end

    it "should refer to the correct services" do
      @person.services << @service
      @person.services.should eq [@service]
    end
  end

  describe "cash_donations associations" do
    before(:each) do
      @donation = FactoryGirl.create(:cash_donation, person_id: @person.id)
    end

    it "should have a cash_donations attribute" do
      @person.should respond_to :cash_donations
    end

    it "should refer to the correct cash donations" do
      @person.cash_donations.should eq [@donation]
    end

    it "should destroy associated cash_donations" do 
      @donations = @person.cash_donations
      @person.destroy 
      @donations.each do |donation| 
        lambda do
          CashDonation.find(donation) 
        end.should raise_error(ActiveRecord::RecordNotFound) 
      end 
    end
  end
end

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

  describe "first_name" do
    it "is an attribute for a person" do
      @person.should respond_to :first_name
    end

    it "is an accessible attribute for a person" do
      @person.should allow_mass_assignment_of :first_name
    end

    it "is present" do
      pending "Check if this should be required"
    end
  end

  describe "last_name" do
    it "is an attribute for a person" do
      @person.should respond_to :last_name
    end

    it "is an accessible attribute for a person" do
      @person.should allow_mass_assignment_of :last_name
    end

    it "should description" do
      pending "Check if this should be required"
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

    it "should description" do
      pending "Check if this should be required"
    end
  end

  describe "address associations" do
    before(:each) do
      @address = FactoryGirl.create(:address, person: @person)
    end

    it "should have an address attribute" do
      @person.should respond_to :address
    end

    it "should refer to the correct address" do
      @person.address.should eq @address
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
      @service = @place.services.create(FactoryGirl.attributes_for(:service))
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
      @donation = @person.cash_donations.create(FactoryGirl.attributes_for(:cash_donation))
    end

    it "should have a cash_donations attribute" do
      @person.should respond_to :cash_donations
    end

    it "should refer to the correct cash donations" do
      @person.cash_donations.should eq [@donation]
    end
  end
end

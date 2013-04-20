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

class Group < ActiveRecord::Base
  attr_accessible :members, :name, :person_ids, :cash_donations_attributes
  has_and_belongs_to_many :people
  has_many :group_services, dependent: :destroy
  has_many :services, through: :group_services
  has_many :cash_donations, dependent: :destroy
  accepts_nested_attributes_for :cash_donations, :reject_if => lambda {|t| t[:date].blank? or t[:amount].blank? }, allow_destroy: true

  validates_presence_of :name
end

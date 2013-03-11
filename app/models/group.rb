class Group < ActiveRecord::Base
  attr_accessible :members, :name
  has_and_belongs_to_many :people
  has_many :group_services
  has_many :services, through: :group_services
  has_many :cash_donations
end

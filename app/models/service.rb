class Service < ActiveRecord::Base
  attr_accessible :date, :description, :hours, :notes, :returned_survey, :sent_survey, :trained, :willing_to_return, :place_id
  has_and_belongs_to_many :people
  has_many :group_services
  has_many :groups, through: :group_services
  belongs_to :place
  has_one :in_kind_donation
end

class Address < ActiveRecord::Base
  attr_accessible :city, :person_id, :state, :street, :zip
  belongs_to :person

  validates_uniqueness_of :person_id
end

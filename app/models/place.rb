class Place < ActiveRecord::Base
  attr_accessible :city
  has_many :services
end

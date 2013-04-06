# == Schema Information
#
# Table name: places
#
#  id         :integer          not null, primary key
#  city       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Place < ActiveRecord::Base
  attr_accessible :city
  has_many :services, dependent: :destroy

  validates_presence_of :city
end
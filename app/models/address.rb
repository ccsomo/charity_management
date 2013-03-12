# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  person_id  :integer          not null
#  street     :string(255)
#  city       :string(255)
#  state      :string(2)
#  zip        :string(11)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Address < ActiveRecord::Base
  attr_accessible :city, :person_id, :state, :street, :zip
  belongs_to :person

  validates_uniqueness_of :person_id
end

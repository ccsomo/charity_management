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
  attr_accessible :members, :name
  has_and_belongs_to_many :people
  has_many :group_services, dependent: :destroy
  has_many :services, through: :group_services
  has_many :cash_donations, dependent: :destroy

  validates_presence_of :name
end

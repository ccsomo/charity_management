# == Schema Information
#
# Table name: skills
#
#  id          :integer          not null, primary key
#  description :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Skill < ActiveRecord::Base
  attr_accessible :description
  has_and_belongs_to_many :people
  validates_presence_of :description
end

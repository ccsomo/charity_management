# == Schema Information
#
# Table name: services
#
#  id                :integer          not null, primary key
#  date              :date             not null
#  place_id          :integer          not null
#  description       :string(255)      not null
#  notes             :text
#  hours             :integer          not null
#  sent_survey       :boolean          default(FALSE)
#  returned_survey   :boolean          default(FALSE)
#  trained           :boolean          default(FALSE)
#  willing_to_return :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Service < ActiveRecord::Base
  attr_accessible :date, :description, :hours, :notes, :returned_survey, :sent_survey, :trained, :willing_to_return, :place_id, :person_ids, :group_ids
  has_and_belongs_to_many :people
  has_many :group_services, dependent: :destroy
  has_many :groups, through: :group_services
  belongs_to :place
  has_one :in_kind_donation, dependent: :destroy

  validates_presence_of :date
  validates_presence_of :place_id
  validates_presence_of :hours
  validates_presence_of :description
end

# == Schema Information
#
# Table name: group_services
#
#  id             :integer          not null, primary key
#  group_id       :integer          not null
#  service_id     :integer          not null
#  members_served :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class GroupService < ActiveRecord::Base
  attr_accessible :group_id, :members_served, :service_id
  belongs_to :group
  belongs_to :service

  validates_presence_of :group_id
  validates_presence_of :service_id
  validates_presence_of :members_served
end

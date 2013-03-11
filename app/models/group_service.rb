class GroupService < ActiveRecord::Base
  attr_accessible :group_id, :members_served, :service_id
  belongs_to :group
  belongs_to :service
end

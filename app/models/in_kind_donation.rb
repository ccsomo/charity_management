# == Schema Information
#
# Table name: donations
#
#  id           :integer          not null, primary key
#  date         :date             not null
#  type         :string(255)
#  group_id     :integer
#  person_id    :integer
#  service_id   :integer
#  amount       :integer
#  dollar_value :integer
#  description  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class InKindDonation < Donation
  attr_accessible :description, :dollar_value, :donation_id, :service_id
  belongs_to :service
end

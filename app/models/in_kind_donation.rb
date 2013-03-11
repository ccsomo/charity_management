class InKindDonation < Donation
  attr_accessible :description, :dollar_value, :donation_id, :service_id
  belongs_to :service
end

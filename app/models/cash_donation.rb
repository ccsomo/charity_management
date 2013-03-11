class CashDonation < Donation
  attr_accessible :amount, :donation_id, :group_id, :person_id
  belongs_to :person
  belongs_to :group
end

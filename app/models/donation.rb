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

class Donation < ActiveRecord::Base
  attr_accessible :date
  # validate :either_cash_or_in_kind
  validates_presence_of :date

  private
    def either_cash_or_in_kind
      case self.type
      when 'CashDonation'
        errors.add(:amount, "can't be blank") if self.amount.blank?
      when 'InKindDonation'
        
      end
    end
end

# class CashDonation < Donation
#   attr_accessible :amount
#   belongs_to :person
#   belongs_to :group

#   validates_presence_of :date
#   validates_presence_of :amount
# end

# class InKindDonation < Donation
#   attr_accessible :description, :dollar_value, :donation_id, :service_id
#   belongs_to :service
# end

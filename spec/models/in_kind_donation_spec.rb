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

require 'spec_helper'

describe InKindDonation do
  pending "add some examples to (or delete) #{__FILE__}"
end

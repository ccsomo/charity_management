# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  person_id  :integer          not null
#  street     :string(255)
#  city       :string(255)
#  state      :string(2)
#  zip        :string(11)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Address do
  pending "add some examples to (or delete) #{__FILE__}"
end

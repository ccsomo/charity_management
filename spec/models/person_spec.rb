# == Schema Information
#
# Table name: people
#
#  id                :integer          not null, primary key
#  first_name        :string(255)
#  last_name         :string(255)
#  representative_id :integer
#  email             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Person do
  pending "add some examples to (or delete) #{__FILE__}"
end
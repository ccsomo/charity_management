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

class Person < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :city, :state, :street, :zip
  belongs_to :representative, class_name: "Person", foreign_key: :representative_id
  has_many :represents, class_name: "Person", foreign_key: :representative_id
  has_and_belongs_to_many :skills
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :services
  has_many :cash_donations

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_format_of :email, with: EMAIL_REGEX
end

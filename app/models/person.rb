class Person < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :representative_id
  belongs_to :representative, class_name: "Person", foreign_key: :representative_id
  has_many :represents, class_name: "Person", foreign_key: :representative_id
  has_one :address
  has_and_belongs_to_many :skills
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :services
  has_many :cash_donations
end

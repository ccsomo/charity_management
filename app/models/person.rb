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
  attr_accessible :email, :name, :city, :state, :street, :zip, :skill_ids, :group_ids, :service_ids, :representative_id, :represent_ids,  :cash_donations_attributes
  belongs_to :representative, class_name: "Person", foreign_key: :representative_id
  has_many :represents, class_name: "Person", foreign_key: :representative_id
  has_and_belongs_to_many :skills
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :services
  has_many :cash_donations, dependent: :destroy
  accepts_nested_attributes_for :cash_donations, :reject_if => lambda {|t| t[:date].blank? or t[:amount].blank? }, allow_destroy: true
  validate :either_name_or_email
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z|^$/i

  validates_format_of :email, with: EMAIL_REGEX

  def composite_address
    "#{street} #{city}, #{state} #{zip}"
  end

  private
    def either_name_or_email
      if self.name.blank? and self.email.blank?
        errors[:base] << "Name and email can't both be blank."
      end
    end
end

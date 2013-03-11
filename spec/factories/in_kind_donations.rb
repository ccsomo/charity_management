# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :in_kind_donation do
    donation_id 1
    service_id 1
    description "MyText"
    dollar_value "9.99"
  end
end

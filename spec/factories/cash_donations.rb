# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cash_donation do
    donation_id 1
    person_id 1
    group_id 1
    amount "9.99"
  end
end

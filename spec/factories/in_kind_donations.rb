# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :in_kind_donation, parent: :donation do
    description       "Food for thought...bot"
    dollar_value      9.99
  end
end

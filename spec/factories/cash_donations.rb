# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cash_donation, parent: :donation do
    amount        9.99
  end
end

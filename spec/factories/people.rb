# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    first_name            "Brad"
    last_name             "Rice"
    email                 "brice@thermaldonkey.com"
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    first_name            "Brad"
    last_name             "Rice"
    email                 "brice@thermaldonkey.com"
    street            	  "5600 N 17th St"
    city              	  "Ozark"
    state             	  "MO"
    zip                   "65721"
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    person_id 1
    street "MyString"
    city "MyString"
    state "MyString"
    zip "MyString"
  end
end

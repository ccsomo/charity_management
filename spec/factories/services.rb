# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
    date "2013-03-10"
    description "MyString"
    notes "MyString"
    hours 1
    sent_survey false
    returned_survey false
    trained false
    willing_to_return false
  end
end

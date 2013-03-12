# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
    date                    "2013-03-10"
    description             "Construct a database"
    notes                   "Once upon a time, two young college guys...."
    hours                   1
    sent_survey             false
    returned_survey         false
    trained                 false
    willing_to_return       false
  end
end

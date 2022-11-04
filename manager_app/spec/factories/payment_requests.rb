# This will guess the User class
FactoryBot.define do
  factory :payment_request do
    sequence :remote_id

    payload { { description: 'Desc' } }
    status { 'pending' }

    trait :accepted do
      status { 'accepted' }
      decided_at { DateTime.current }
    end
  end
end

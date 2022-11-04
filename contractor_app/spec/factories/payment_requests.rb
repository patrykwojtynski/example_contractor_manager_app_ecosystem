# This will guess the User class
FactoryBot.define do
  factory :payment_request do
    amount_cents { 111 }
    amount_currency { 'PLN' }
    description { 'Desc' }
    status { 'pending' }
  end
end

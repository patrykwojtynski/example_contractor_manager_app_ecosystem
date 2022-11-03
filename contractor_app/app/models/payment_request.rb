class PaymentRequest < ApplicationRecord
  enum status: [ :pending, :accepted, :rejected ], _prefix: true, _scopes: false
end

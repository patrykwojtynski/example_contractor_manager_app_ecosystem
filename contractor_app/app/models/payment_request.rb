class PaymentRequest < ApplicationRecord
  enum status: [ :pending, :accepted, :rejected ], _prefix: true, _scopes: false
  monetize :amount_cents, numericality: {
    greater_than: 0
  }
end

class PaymentRequest < ApplicationRecord
  enum status: [ :pending, :accepted, :rejected ], _prefix: true, _scopes: false
  validates :remote_id, presence: true, uniqueness: true
end

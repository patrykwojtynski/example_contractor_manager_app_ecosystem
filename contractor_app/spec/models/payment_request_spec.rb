require 'rails_helper'
require "money-rails/test_helpers"

describe PaymentRequest, type: :model do
  it { is_expected.to monetize(:amount) }
end

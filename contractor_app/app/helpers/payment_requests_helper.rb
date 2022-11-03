module PaymentRequestsHelper
  def all_currencies
    Money::Currency.table.keys.map(&:upcase)
  end
end

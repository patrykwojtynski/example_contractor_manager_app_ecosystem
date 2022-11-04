class PaymentRequestsConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      PaymentRequestsManager::Creator.call(message.key, message.payload)
    end
  end
end

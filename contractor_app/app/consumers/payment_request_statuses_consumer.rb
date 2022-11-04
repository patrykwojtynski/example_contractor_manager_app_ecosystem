class PaymentRequestStatusesConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      PaymentRequestsManager::StatusUpdater.call(message.key, message.payload)
    end
  end
end

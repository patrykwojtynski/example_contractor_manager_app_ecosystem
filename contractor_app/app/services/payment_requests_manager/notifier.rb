module PaymentRequestsManager
  class Notifier < ApplicationService
    KAFKA_TOPIC='payment_requests'.freeze

    def initialize(payment_request)
      @payment_request = payment_request
    end

    def call
      Karafka.producer.produce_async(
        topic: self.class::KAFKA_TOPIC,
        payload: json_payload,
        key: @payment_request.id.to_s
      )
    end

    private

    def json_payload
      @payment_request.to_json(only: %i[id created_at description amount_cents amount_currency])
    end
  end
end

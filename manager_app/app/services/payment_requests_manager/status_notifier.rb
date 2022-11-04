module PaymentRequestsManager
  class StatusNotifier < ApplicationService
    KAFKA_TOPIC='payment_request_statuses'.freeze

    def initialize(payment_request)
      @payment_request = payment_request
    end

    def call
      return if @payment_request.status_pending?

      Karafka.producer.produce_async(
        topic: self.class::KAFKA_TOPIC,
        payload: json_payload,
        key: @payment_request.remote_id.to_s
      )
    end

    private

    def json_payload
      {
        id: @payment_request.remote_id,
        status: @payment_request.status,
        decided_at: @payment_request.decided_at
      }.to_json
    end
  end
end

class CreatePaymentRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_requests do |t|
      t.monetize :amount
      t.text :description
      t.integer :status, default: 0, null: false
      t.datetime :decision_timestamp

      t.timestamps
    end
  end
end

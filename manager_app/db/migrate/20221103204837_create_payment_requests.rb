class CreatePaymentRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_requests do |t|
      t.integer :remote_id, null: false
      t.jsonb :payload
      t.integer :status, default: 0, null: false
      t.datetime :decided_at

      t.timestamps
    end

    add_index :payment_requests, :remote_id,  unique: true
  end
end

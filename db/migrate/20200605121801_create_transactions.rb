class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :uuid
      t.integer :amount
      t.integer :status
      t.string :customer_email
      t.string :customer_phone
      t.string :type
      t.integer :transaction_id
      t.references :user

      t.timestamps
    end
  end
end

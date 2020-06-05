class ChangeColumnType < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :total_transaction_sum, :integer, using: 'total_transaction_sum::integer'
  end
end

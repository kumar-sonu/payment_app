class Reversal < Transaction
  belongs_to :associated_transaction, foreign_key: :transaction_id, class_name: 'Transaction'

  validates :amount, absence: true

  after_create :sync_transaction

  def sync_transaction
    # set status to refunded for associated authorized_transaction
    authorized_transaction = associated_transaction.associated_transactions.authorized.approved.last
    authorized_transaction&.update_attributes(status: :reversed)
  end
end

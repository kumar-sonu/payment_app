class Refund < Transaction
  belongs_to :associated_transaction, foreign_key: :transaction_id, class_name: 'Transaction'

  validates :amount, numericality: { greater_than: 0 }

  after_create :sync_transaction

  def sync_transaction
    # set status to refunded for associated charged_transaction
    charged_transaction = associated_transaction.associated_transactions.charged.approved.last
    charged_transaction&.update_attributes(status: :refunded)

    # adjust total_transaction_sum for merchant
    associated_transaction.user.save
  end
end

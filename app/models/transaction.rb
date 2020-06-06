class Transaction < ApplicationRecord
  belongs_to :user
  has_many :associated_transactions, foreign_key: :transaction_id, class_name: 'Transaction'

  { authorized: 'Authorize', charged: 'Charge', refunded: 'Refund',
    reversed: 'Reversal' }.each do |name, type|
    scope name.to_sym, -> { where(type: type) }
  end

  enum status: %i[approved reversed refunded error]
  before_validation :add_uuid, on: :create

  validates :customer_email, presence: true, email: true
  validates :uuid, :status, presence: true

  scope :older_than, ->(time) { where('created_at < ?', time) }

  def add_uuid
    self.uuid ||= SecureRandom.uuid
  end
end

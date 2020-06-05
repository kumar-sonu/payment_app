class Transaction < ApplicationRecord
  belongs_to :user
  has_many :associated_transactions, foreign_key: :transaction_id, class_name: 'Transaction'

  scope :authorized, -> { where(type: 'Authorize') }
  scope :charged, -> { where(type: 'Charge') }
  scope :refunded, -> { where(type: 'Refund') }
  scope :reversed, -> { where(type: 'Reversal') }

  enum status: %i[approved reversed refunded error]
  before_validation :add_uuid, on: :create

  validates :customer_email,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                      on: :create }
  validates :uuid, :status, presence: true

  scope :older_than, ->(time) { where('created_at < ?', time) }

  def add_uuid
    self.uuid ||= SecureRandom.uuid
  end
end

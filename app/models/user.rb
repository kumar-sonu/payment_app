class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :transactions

  enum role: %i[admin merchant]
  enum status: %i[active inactive]

  scope :admins, -> { where(role: :admin) }
  scope :merchants, -> { where(role: :merchant) }

  # set default role to merchant as soon as we initialize the User
  after_initialize do
    self.role ||= :merchant if new_record?
  end

  before_save do
    self.total_transaction_sum = transactions.charged.approved.sum(:amount) if merchant?
  end
end

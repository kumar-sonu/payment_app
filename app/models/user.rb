class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :transactions

  enum role: %i[admin merchant]
  enum status: %i[active inactive]

  # set default role to merchant as soon as we initialize the User
  after_initialize do
    self.role ||= :merchant if new_record?
  end
end

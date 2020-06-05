class User < ApplicationRecord
  enum role: %i[admin merchant]
  enum status: %i[active inactive]

  # set default role to merchant as soon as we initialize the User
  after_initialize do
    self.role ||= :merchant if new_record?
  end
end

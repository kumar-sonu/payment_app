class AuthenticateUser
  prepend SimpleCommand
  attr_accessor :email, :password

  # this is where parameters are taken when the command is called
  def initialize(email, password)
    @email = email
    @password = password
  end

  # this is where the result gets returned
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  def user
    user = User.find_by_email(email)
    unless user.present?
      errors.add :message, 'No user found for this email'
      return nil
    end

    unless user.valid_password?(password)
      errors.add :message, 'Invalid email or password'
      return nil
    end

    # inactive merchants can't create transactions
    unless user.merchant? && user.active?
      errors.add :message, 'Only active merchant can create transactions!!!'
      return nil
    end

    user
  end
end

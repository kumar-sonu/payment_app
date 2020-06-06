module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end
  class DecodeError < StandardError; end

  included do
    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :unprocessable_entity
    rescue_from ExceptionHandler::InvalidToken, with: :unprocessable_entity
    rescue_from ExceptionHandler::ExpiredSignature, with: :expired_token
    rescue_from ExceptionHandler::DecodeError, with: :unable_to_decode

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  private

  # JSON response with message; Status code 422 - Unprocessable entity
  def unprocessable_entity(e)
    render json: { message: e.message }, status: :unprocessable_entity
  end

  # JSON response with message; Status code 498 - Unauthorized
  def expired_token(e)
    render json: { message: e.message }, status: 498
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unable_to_decode(e)
    render json: { message: e.message }, status: 401
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(e)
    render json: { message: e.message }, status: :unauthorized
  end
end

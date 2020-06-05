class Api::AuthenticationController < Api::ApplicationController
  skip_before_action :authenticate_request

  # this method is used for user authentication if user is authenticated
  # he will get the token to call other APIs
  def authenticate_user
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: {
        access_token: command.result,
        message: 'Authentication Successful'
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end

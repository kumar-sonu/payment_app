module Api
  class ApplicationController < ActionController::API
    before_action :authenticate_request
    attr_reader :current_api_user

    private

    def authenticate_request
      @current_api_user = AuthorizeApiRequest.call(request.headers)
                                             .result

      return @current_api_user if @current_api_user

      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end
end

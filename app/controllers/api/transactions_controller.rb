module Api
  class TransactionsController < Api::ApplicationController
    include ExceptionHandler

    def create
      @transaction = @current_api_user.transactions.new(transaction_params)
      @transaction.save!

      render json: @transaction, status: :created
    rescue ActiveRecord::RecordInvalid => e
      raise ActiveRecord::RecordInvalid, e.message
    end

    private

    def transaction_params
      params.permit(:amount, :status, :customer_email, :customer_phone, :type,
                    :transaction_id)
    end
  end
end

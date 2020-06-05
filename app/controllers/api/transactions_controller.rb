module Api
  class TransactionsController < Api::ApplicationController
    def create
      @transaction = @current_api_user.transactions.new(transaction_params)
      if @transaction.save
        render json: @transaction, status: :created
      else
        render json: { errors: @transaction.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    private

    def transaction_params
      params.permit(:amount, :status, :customer_email, :customer_phone, :type,
                    :transaction_id)
    end
  end
end

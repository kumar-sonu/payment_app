class TransactionsController < ApplicationController
  before_action :set_user

  def index
    @transactions = @user.transactions.order(created_at: :desc)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:user_id])
  end
end

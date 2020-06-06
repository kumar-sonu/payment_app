require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let!(:user) { FactoryBot.create(:user, role: :merchant) }
  subject(:context) { described_class.call(token) }

  describe '.call' do
    context 'when the context is successful' do
      let(:token) do
        { 'Authorization' => JsonWebToken.encode(user_id: user.id) }
      end

      it 'succeeds' do
        expect(context).to be_success
      end
    end

    context 'when the context is not successful' do
      let(:token) do
        { 'Authorization' => JsonWebToken.encode({ user_id: user.id }, 5.minutes.ago) }
      end

      it 'fails' do
        expect { context }.to raise_error(ExceptionHandler::ExpiredSignature)
      end
    end
  end
end

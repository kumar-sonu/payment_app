require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.create(:user) }

  let!(:base_transaction) { FactoryBot.create(:transaction, user: subject) }
  let!(:charged_transaction) do
    FactoryBot.create(:transaction, user: subject, type: 'Charge',
                                    amount: base_transaction.amount,
                                    transaction_id: base_transaction.id)
  end

  it { should validate_presence_of(:email) }
  it { expect(subject.admin?).to eq(false) }
  it { expect(subject.merchant?).to eq(true) }
  it { expect(subject.active?).to eq(true) }
  it { should allow_values('active', 'inactive').for(:status) }
  it { should allow_value('email@addresse.foo').for(:email) }
  it { should_not allow_value('email').for(:email) }

  context 'total_transaction_sum' do
    before(:each) { subject.save }

    it { expect(subject.total_transaction_sum).to eq(charged_transaction.amount) }
  end
end

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:transaction)).to be_valid
  end
  it { should validate_presence_of(:status) }

  subject { FactoryBot.create(:transaction) }
  context do
    it { should validate_presence_of(:uuid) }
  end
  it { should allow_values('approved', 'reversed', 'refunded', 'error').for(:status) }
  it { should allow_value('email@addresse.foo').for(:customer_email) }
end

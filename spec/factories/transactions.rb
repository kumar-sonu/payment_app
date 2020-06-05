FactoryBot.define do
  factory :transaction do
    user
    amount { Faker::Number.number(digits: 3) }
    customer_email { Faker::Internet.email }
    status { 'approved' }
  end
end

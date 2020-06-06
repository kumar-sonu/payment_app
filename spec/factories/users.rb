FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    description { Faker::Lorem.sentence(word_count: 3) }
    password { Faker::Internet.password(min_length: 8) }
    status { 'active' }
  end
end

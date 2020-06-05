require 'csv'

namespace :db do
  desc 'Create users from CSV'
  task create_users: :environment do
    data = File.open('user_data.csv')
    CSV.foreach(data, headers: true) do |row|
      attrs = row.to_hash
      attrs['status'] = 'inactive' unless attrs['status'].eql?('active')

      u = User.find_or_initialize_by(attrs.except('password')) do |user|
        user.password = attrs['password']
      end

      if u.save
        puts 'User created successfully'
      else
        puts "Error occurred while creating user\n#{u.errors.full_messages.join(",\n")}"
      end
    end
  rescue StandardError => e
    puts "An error occurred while processing file: #{e.message}"
  end
end

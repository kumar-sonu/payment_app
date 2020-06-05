desc 'Deletes the Transactions older than 1 hour'
task transaction_cleanup: :environment do
  Transaction.older_than(1.hour.ago).destroy_all
end

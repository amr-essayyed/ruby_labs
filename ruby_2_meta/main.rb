require_relative 'user'
require_relative 'transaction'
require_relative 'cba_bank'

users = [
  User.new("Ali", 200),
  User.new("Peter", 500),
  User.new("Manda", 100)
]

out_side_bank_users = [
  User.new("Menna", 400),
]

transactions = [
  Transaction.new(users[0], -20),
  Transaction.new(users[0], -30),
  Transaction.new(users[0], -50),
  Transaction.new(users[0], -100),
  Transaction.new(users[0], -100),
  Transaction.new(out_side_bank_users[0], -100)
]

hamoBank = CBABank.new(users)

hamoBank.process_transactions(transactions) do |status, transaction|
    if status == "success"
        puts "Transaction for user #{transaction.user.name} with value #{transaction.value} succeeded."
    else
        puts "Transaction for user #{transaction.user.name} with value #{transaction.value} failed."
    end
end
require_relative 'bank'
require_relative 'logger'

class CBABank < Bank
  include Logger

  def initialize(users)
    @users = users
  end

  def process_transactions(transactions, &callback)
    log_info("Processing Transactions #{transactions.map { |t| "User #{t.user.name} transaction with value #{t.value}" }.join(', ')}...")

    transactions.each do |transaction|
      begin
        if @users.include?(transaction.user)
          new_balance = transaction.user.balance + transaction.value

          if new_balance < 0
            raise "Not enough balance"
          end

          transaction.user.balance = new_balance

          if new_balance == 0
            log_warning("#{transaction.user.name} has 0 balance")
          end

          log_info("User #{transaction.user.name} transaction with value #{transaction.value} succeeded")
          callback.call("success", transaction)
        else
          raise "#{transaction.user.name} not exist in the bank!!"
        end
      rescue => e
        log_error("User #{transaction.user.name} transaction with value #{transaction.value} failed with message #{e}")
        callback.call("failure", transaction)
      end
    end
  end
end

class Bank
  def process_transactions(transactions, &callback)
    raise NotImplementedError, 'Subclasses must implement the process_transactions method'
  end
end

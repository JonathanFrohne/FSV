trait Account {
  var balance: int

  // Method to retrieve the balance
  function GetBalance(): (ret: int)
    reads this
    ensures ret == balance
  {
    balance  // Return the current balance
  }

  // Method to deposit an amount
  method Deposit(amount: int)
    modifies this
    requires amount > 0
    ensures balance == old(balance) + amount
  {
    balance := balance + amount;
  }

  // Method to withdraw an amount
  method Withdraw(amount: int)
    modifies this
    requires balance >= amount && amount > 0
    ensures balance == old(balance) - amount
  {
    balance := balance - amount;
  }
}
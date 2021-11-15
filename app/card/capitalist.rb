class Capitalist < Card
  TYPE = name.downcase
  BALANCE = 100
  PART_WITHDRAW_TAX = 0.04
  PUT_TAX = 10
  PART_SEND_TAX = 0.1

  def initialize(balance = BALANCE)
    super(TYPE, balance)
  end

  def withdraw_tax(amount)
    amount * PART_WITHDRAW_TAX
  end

  def put_tax(_amount)
    PUT_TAX
  end

  def send_tax(amount)
    amount * PART_SEND_TAX
  end
end

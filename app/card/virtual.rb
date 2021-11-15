class Virtual < Card
  TYPE = name.downcase
  BALANCE = 150
  PART_WITHDRAW_TAX = 0.88
  PUT_TAX = 1
  SEND_TAX = 1

  def initialize(balance = BALANCE)
    super(TYPE, balance)
  end

  def withdraw_tax(amount)
    amount * PART_WITHDRAW_TAX
  end

  def put_tax(_amount)
    PUT_TAX
  end

  def send_tax(_amount)
    SEND_TAX
  end
end

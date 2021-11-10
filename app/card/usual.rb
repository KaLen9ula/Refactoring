class Usual < Card
  TYPE = name.downcase
  BALANCE = 50
  PART_WITHDRAW_TAX = 0.05
  PART_PUT_TAX = 0.02
  SEND_TAX = 20

  def initialize(balance = BALANCE)
    super(TYPE, balance)
  end

  def withdraw_tax(amount)
    amount * PART_WITHDRAW_TAX
  end

  def put_tax(amount)
    amount * PART_PUT_TAX
  end

  def send_tax(_amount)
    SEND_TAX
  end
end

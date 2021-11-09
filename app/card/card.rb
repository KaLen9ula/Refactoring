class Card
  attr_reader :type, :card_number
  attr_accessor :balance

  TYPE = I18n.t('type_card.simple').freeze
  BALANCE = 0
  NULL = 0
  CARD_NUMBER_LENGTH = 16

  def initialize(type, balance = BALANCE)
    @type = type
    @balance = balance
    @card_number = CARD_NUMBER_LENGTH.times.map { rand(10) }.join
  end

  def withdraw_tax(_amount)
    NULL
  end

  def put_tax(_amount)
    NULL
  end

  def send_tax(_amount)
    NULL
  end

  def self.type
    self::TYPE
  end

  def withdraw_money(amount)
    @balance -= amount - withdraw_tax(amount)
  end

  def put_money(amount)
    @balance += amount - put_tax(amount)
  end

  def send_money(amount)
    @balance -= amount - sender_tax(amount)
  end

  def withdraw_available?(amount)
    (@balance - amount - withdraw_tax(amount)).positive?
  end

  def put_available?(amount)
    put_tax(amount) < amount
  end

  def send_available?(amount)
    (@balance - amount - sender_tax(amount)).positive?
  end
end
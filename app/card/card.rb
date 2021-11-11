class Card
  attr_reader :type, :card_number
  attr_accessor :balance

  TYPE = I18n.t('type_card.simple').freeze
  BALANCE = 0
  CARD_NUMBER_LENGTH = 16
  CARD_NUMBER_RANGE = (0..9).freeze

  def initialize(type, balance = BALANCE)
    @type = type
    @balance = balance
    @card_number = Array.new(CARD_NUMBER_LENGTH) { rand(CARD_NUMBER_RANGE) }.join
  end

  def withdraw_tax(amount = 0)
    amount
  end

  def put_tax(amount = 0)
    amount
  end

  def send_tax(amount = 0)
    amount
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

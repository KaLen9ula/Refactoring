class Account
  attr_reader :cards, :name, :login, :password

  def initialize(name, login, password, age)
    @cards = []
    @name = name
    @login = login
    @password = password
    @age = age
  end

  def add_card(new_card)
    @cards << new_card
  end

  def remove_card(card)
    @cards.delete_at(@cards.index(card))
  end

  def find_card_by_index(index)
    @cards[index] if (0..@cards.length).cover?(index)
  end

  def access?(login, password)
    login == @login && password == @password
  end
end

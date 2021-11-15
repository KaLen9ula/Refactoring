class CardOperation
  include InputHelper
  include OutputHelper

  def initialize(database, account)
    @database = database
    @account = account
  end

  CARDS = [
    Usual,
    Capitalist,
    Virtual
  ].freeze

  def create_card_operation
    loop do
      print_multiline_text('card')
      create_card? ? break : next
    end
  end

  def destroy_card_operation
    card = select_card(I18n.t('request.delete'))
    return unless card

    destroy_card(card) if agree_delete?(card)
  end

  def show_account_cards
    return unless any_card?

    @account.cards.each do |card|
      print_to_console('notification.show_card', card_number: card.card_number, card_type: card.type)
    end
  end

  def select_card(request_text, wrong_number_text = I18n.t('notification.wrong_number'))
    puts request_text
    return unless any_card?

    card_menu_output
    receive_card(wrong_number_text)
  end

  def search_recipient_card
    number_card = acquire_input(I18n.t('input.recipient_card'))
    if number_card.length == Card::CARD_NUMBER_LENGTH
      return find_card(number_card) unless detected_card.nil?

      print_to_console('notification.no_number_card', number_card: number_card)
    else
      print_to_console('request.correct_number_card')
    end
  end

  private

  def create_card?
    card_type = acquire_input
    if CARDS.map(&:type).include?(card_type)
      @account.add_card(CARDS.detect { |klass| klass.type == card_type }.new)
      @database.update_database
      return true
    end
    print_to_console('notification.wrong_type_card')
  end

  def receive_card(wrong_number_text)
    card_sequence_number = receive_card_sequence_number
    return unless card_sequence_number

    card = @account.find_card_by_index(card_sequence_number.to_i - 1)
    return card unless card.nil?

    puts wrong_number_text
    receive_card(wrong_number_text)
  end

  def receive_card_sequence_number
    card_sequence_number = acquire_input
    return if card_sequence_number == I18n.t('commands.exit')

    card_sequence_number
  end

  def agree_delete?(card)
    answer = acquire_input(I18n.t('request.destroy_card', card_number: card.card_number))
    answer == I18n.t('commands.agree')
  end

  def destroy_card(card)
    @account.remove_card(card)
    @database.update_database
  end

  def card_menu_output
    @account.cards.each_with_index do |card, index|
      print_to_console('request.number_to_press', card_number: card.card_number, card_type: card.type, index: index + 1)
    end
    print_to_console('request.to_exit')
  end

  def any_card?
    return true if @account.cards.any?

    print_to_console('notification.no_card')
  end

  def find_card(number_card)
    @database.accounts.map(&:cards).detect { |card| card.card_number == number_card }
  end
end

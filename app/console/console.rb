class Console
  include InputHelper
  include OutputHelper
  attr_reader :current_account

  COMMANDS = {
    I18n.t('commands.show_cards') => :show_cards,
    I18n.t('commands.create_card') => :create_card,
    I18n.t('commands.destroy_card') => :destroy_card,
    I18n.t('commands.put_money') => :put_money,
    I18n.t('commands.withdraw_money') => :withdraw_money,
    I18n.t('commands.send_money') => :send_money,
    I18n.t('commands.destroy_account') => :destroy_account
  }.freeze

  def initialize
    @database = Database.new
  end

  def console
    print_multiline_text('console')
    case acquire_input
    when I18n.t('commands.create') then create
    when I18n.t('commands.load') then load
    else exit end
  end

  def create
    registration = AccountRegistration.new(@database)
    account_data = registration.registration_data

    @current_account = Account.new(account_data[:name], account_data[:login], account_data[:password],
                                   account_data[:age])
    @database.add_account(@current_account)
    setup_operation
    main_menu
  end

  def load
    return create_first_account if @database.accounts.none?

    authorization = AccountLogIn.new(@database)
    @current_account = authorization.log_in
    setup_operation
    main_menu
  end

  def create_first_account
    answer = acquire_input(I18n.t('request.first_account'))
    answer == I18n.t('commands.agree') ? create : console
  end

  def main_menu
    loop do
      print_to_console('menu', account_name: @current_account.name)
      command = acquire_input
      exit if command == I18n.t('commands.exit')
      return public_send(COMMANDS[command]) if COMMANDS.keys.include?(command)

      print_to_console('notification.wrong_command')
    end
  end

  def destroy_account
    answer = acquire_input(I18n.t('request.destroy_account'))
    @database.delete_account(@current_account) if answer == I18n.t('commands.agree')
  end

  def create_card
    @card_operation.create_card_operation
  end

  def destroy_card
    @card_operation.destroy_card_operation
  end

  def show_cards
    @card_operation.show_account_cards
  end

  def withdraw_money
    @money_operation.withdraw_money_operation
  end

  def put_money
    @money_operation.put_money_operation
  end

  def send_money
    @money_operation.send_money_operation
  end

  private

  def setup_operation
    @card_operation = CardOperation.new(@database, @current_account)
    @money_operation = MoneyOperation.new(@database, @current_account)
  end
end

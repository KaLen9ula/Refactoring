class AccountLogIn
  include InputHelper
  include OutputHelper

  def initialize(database)
    @database = database
  end

  def log_in
    account = receieve_account
    if account.nil?
      print_to_console('warning.not_suitable_account')
      log_in
    else
      account
    end
  end

  private

  def receieve_account
    login = acquire_input(I18n.t('request.login'))
    password = acquire_input(I18n.t('request.password'))

    @database.accounts.detect { |account| account.access? login, password }
  end
end

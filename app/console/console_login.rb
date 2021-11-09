require_relative '../../autoloader'

class AccountLogIn
  include InputHelper

  def initialize(database)
    @database = database
  end

  def log_in
    account = receieve_account
    if account.nil?
      puts I18n.t('warning.not_suitable_account')
      log_in
    else
      account
    end
  end

  private

  def receieve_account
    login = acquire_input(I18n.t('request.login'))
    password = acquire_input(I18n.t('request.password'))

    @database.accounts.detect { |a| a.access? login, password }
  end
end

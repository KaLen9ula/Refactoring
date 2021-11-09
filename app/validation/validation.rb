require 'pry'

class AccountValidator
  MIN_LOGIN_SIZE = 4
  MAX_LOGIN_SIZE = 20
  MIN_PASSWORD_SIZE = 6
  MAX_PASSWORD_SIZE = 30
  MIN_AGE_SIZE = 23
  MAX_AGE_SIZE = 90

  def initialize(database)
    @errors = []
    @database = database
  end

  def validate_name(name)
    return unless name.empty? || name[0].upcase != name[0]

    @errors << I18n.t('validation.invalid_name')
  end

  def validate_login(login)
    @errors << I18n.t('validation.login_present') if login.empty?
    @errors << I18n.t('validation.login_shorter') if login.length > MAX_LOGIN_SIZE
    @errors << I18n.t('validation.login_longer') if login.length < MIN_LOGIN_SIZE
    @errors << I18n.t('validation.login_exists') if @database.accounts.map(&:login).include? login
  end

  def validate_password(password)
    @errors << I18n.t('validation.password_present') if password.empty?
    @errors << I18n.t('validation.password_shorter') if password.length > MAX_PASSWORD_SIZE
    @errors << I18n.t('validation.password_longer') if password.length < MIN_PASSWORD_SIZE
  end

  def validate_age(age)
    @errors << I18n.t('validation.invalid_age') unless (MIN_AGE_SIZE..MAX_AGE_SIZE).cover?(age)
  end

  def output_errors
    @errors.each { |err| puts err }
    @errors = []
  end

  def account_errors?
    @errors.empty?
  end
end

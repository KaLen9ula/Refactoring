class AccountRegistration
  include InputHelper

  def initialize(database)
    @account_validator = AccountValidator.new(database)
  end

  def registration_data
    loop do
      account_data = { name: name_input, age: age_input, login: login_input, password: password_input }
      return account_data if @account_validator.account_errors?

      @account_validator.output_errors
    end
  end

  def name_input
    name = acquire_input(I18n.t('input.name'))
    name_validation(name)
    name
  end

  def login_input
    login = acquire_input(I18n.t('input.login'))
    login_validation(login)
    login
  end

  def password_input
    password = acquire_input(I18n.t('input.password'))
    password_validation(password)
    password
  end

  def age_input
    age = acquire_input(I18n.t('input.age')).to_i
    age_validation(age)
    age
  end

  def name_validation(name)
    @account_validator.validate_name(name)
  end

  def login_validation(login)
    @account_validator.validate_login(login)
  end

  def password_validation(password)
    @account_validator.validate_password(password)
  end

  def age_validation(age)
    @account_validator.validate_age(age)
  end
end

class AccountValidator
  LOGIN_SIZE = (4..20).freeze
  PASSWORD_SIZE = (6..30).freeze
  AGE_SIZE = (23..90).freeze

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
    @errors << I18n.t('validation.login_shorter') if login.length > LOGIN_SIZE.max
    @errors << I18n.t('validation.login_longer') if login.length < LOGIN_SIZE.min
    @errors << I18n.t('validation.login_exists') if login_exists?(login)
  end

  def validate_password(password)
    @errors << I18n.t('validation.password_present') if password.empty?
    @errors << I18n.t('validation.password_shorter') if password.length > PASSWORD_SIZE.max
    @errors << I18n.t('validation.password_longer') if password.length < PASSWORD_SIZE.min
  end

  def validate_age(age)
    @errors << I18n.t('validation.invalid_age') unless (AGE_SIZE.min..AGE_SIZE.max).cover?(age)
  end

  def output_errors
    @errors.each { |error| puts error }
    @errors = []
  end

  def account_errors?
    @errors.empty?
  end

  def login_exists?(login)
    @database.accounts.map(&:login).include? login
  end
end

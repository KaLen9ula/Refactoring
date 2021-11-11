class Database
  attr_reader :accounts

  FILE_PATH = 'accounts.yml'.freeze

  def initialize
    @accounts = load_accounts
  end

  def add_account(account)
    @accounts << account
    update_database
  end

  def delete_account(account)
    @accounts.delete(account)
    update_database
  end

  def update_database
    File.open(FILE_PATH, 'w') { |file| file.write @accounts.to_yaml }
  end

  private

  def load_accounts
    return [] unless File.exist?(FILE_PATH)

    YAML.load_file(FILE_PATH)
  end
end

require 'yaml'
require 'i18n'

I18n.config.load_path << Dir[File.expand_path('config/locales').concat('/*.yml')]
I18n.config.available_locales = :en

require_relative 'app/card/card'
require_relative 'app/card/usual'
require_relative 'app/card/capitalist'
require_relative 'app/card/virtual'
require_relative 'app/helpers/output_helper'
require_relative 'app/helpers/input_helper'
require_relative 'app/validation/validation'
require_relative 'app/database/database'
require_relative 'app/account/account'
require_relative 'app/operations/card_operation'
require_relative 'app/operations/money_operation'
require_relative 'app/console/console_registration'
require_relative 'app/console/console_login'
require_relative 'app/console/console'

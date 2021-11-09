require 'pry'
module OutputHelper
  def output_text(key)
    I18n.t(key).split("\n").each { |line| puts line }
  end
end

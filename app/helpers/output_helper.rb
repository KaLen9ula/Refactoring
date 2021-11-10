module OutputHelper
  def output_text(key)
    I18n.t(key).split("\n").each { |line| puts line }
  end

  def print_to_console(key, **args)
    puts I18n.t(key, **args)
  end
end

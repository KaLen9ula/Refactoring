module InputHelper
  def acquire_amount(question = nil)
    puts question if question
    answer = gets.chomp
    answer.to_i
  end

  def acquire_input(question = nil)
    puts question if question
    gets.chomp
  end
end

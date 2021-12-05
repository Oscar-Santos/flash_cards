class Game
  attr_reader :round,
  :turn_count
  def initialize(round)
    @round = round
    @turn_count = 1
  end

  def start
    puts "Welcome! You're playing with #{@round.deck.count} cards."
    puts "-" * 20
    count = @round.deck.count
    until count == 0 do
      puts "This is card number #{@turn_count} out of #{@round.deck.count}"
      puts "Question: #{@round.current_card.question}"
      guess = gets.chomp
      turn = @round.take_turn(guess)
      puts "#{turn.feedback}"
      @turn_count += 1
      count -= 1
    end
    game_over

  end

  def game_over
    puts "-------GAME OVER-------"
    puts "You had #{@round.number_correct} correct guesses out of #{@round.deck.count} for a total score of #{@round.percent_correct}%."
    game_categories.each do |category|
      puts "#{category.to_s} - #{@round.percent_correct_by_category(category)}% correct"
    end

  end

  def game_categories
    categories = @round.turns.map do |turn|
      turn.card.category
    end
    categories.uniq
  end
end

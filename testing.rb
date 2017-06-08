require './deck'

deck_testing = Deck.new
deck_testing.build_standard_deck
puts "--- TESTING ---"
puts "Amount of cards: #{deck_testing.in_deck_cards.length}"
puts "        ----        "
puts "Last card: #{deck_testing.draw}"
3.times do
  puts "        ----        "
  deck_testing.shuffle
  puts "Last card after shuffle: #{deck_testing.draw}"
end
puts "        ----        "
puts "Draw 3 cards: #{deck_testing.draw(3)}"
puts "        ----        "
puts "Discarded cards: #{deck_testing.out_of_deck_cards.length}"
puts "        ----        "
puts "PRE reset: #{deck_testing.in_deck_cards.length}"
puts "        ----        "
deck_testing.reset_deck
puts "POST reset: #{deck_testing.in_deck_cards.length}"

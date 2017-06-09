require './deck'
require './player'

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
deck_testing.full_deck_reset
puts "POST reset: #{deck_testing.in_deck_cards.length}"
puts "        ----        "
puts "Last 3 cards should not be royal clubs: #{deck_testing.draw(3)}"
puts "        ----        "
hand = deck_testing.draw(3)
puts "Display hand: #{hand.map{|card| card.display}.join(", ")}"
puts "        ----        "
puts "Combined values: #{hand} should == #{hand.inject(0) {|sum, card| sum + card.value}}"


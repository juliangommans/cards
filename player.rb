# Keep track of player details
# - Cards are the cards drawn for the player, basically their hand
# - Score will depend on game type

class Player
  attr_reader :cards, :name, :score

  def initialize(name = "Dealer")
    @cards = []
    @name = name
    @score = 0
  end

  def set_name(name)
    @name = name
  end

  def change_score(amount)
    @score += amount.to_i
  end

  def add_cards_to_hand(drawn)
    cards.concat(drawn)
  end

  def show_hand
    puts "#{name}'s hand contains #{display_cards_in_hand}."
  end

  def display_cards_in_hand
    cards.map{|card| card.display}.join(", ")
  end

  def discard_hand
    return_cards = cards
    cards.clear
    return_cards
  end
end

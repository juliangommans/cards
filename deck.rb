 # - Card class takes a hash of card attributes and assigns them to instance variables that are attr_reader
 # - Deck class builds a deck using the Card class, will have various methods for manipulating the deck, the actual cards will be attr_reader and modified through methods.

class Card

  attr_reader :name, :group, :colour, :value, :icon

  def initialize(details)
    @name = details[:name]
    @group = details[:group]
    @colour = details[:colour]
    @value = details[:value]
    @icon = (name.class.name == "String") ? name[0] : name
  end

  def display
    "#{icon} of #{group}"
  end
end

class Deck

  attr_reader :in_deck_cards, :out_of_deck_cards, :discarded_cards, :groups

  def initialize
    @in_deck_cards = []
    @out_of_deck_cards = []
    @discarded_cards = []
    @groups = ["Hearts", "Diamonds", "Spades", "Clubs"]
  end

  def build_standard_deck
    @groups.each do |group|
      colour = if @groups.index(group) < 2
        "red"
      else
        "black"
      end
      top_deck_card(build_card(group, colour, "Ace", 1))
      build_number_cards(group, colour)
      build_royal_cards(group, colour)
    end
  end

  def top_deck_card(card)
    in_deck_cards.push(card)
  end

  def bottom_deck_card(card)
    in_deck_cards.unshift(card)
  end

  def draw(num = 1)
    cards = in_deck_cards.pop(num)
    out_of_deck_cards.concat(cards)
    cards
  end

  def discard(cards)
    discarded_cards.concat(cards)
  end

  def shuffle
    in_deck_cards.shuffle!
  end

  def full_deck_reset
    reset_deck(out_of_deck_cards)
  end

  def reset_discarded_cards
    reset_deck(discarded_cards)
  end

  private

  def build_royal_cards(group, colour)
    ["Jack", "Queen", "King"].each do |card|
      top_deck_card(build_card(group, colour, card, 10))
    end
  end

  def build_number_cards(group, colour)
    (2..10).to_a.each do |num|
      top_deck_card(build_card(group, colour, num, num))
    end
  end

  def build_card(group, colour, name, value)
    card_details = {
      group: group,
      colour: colour,
      name: name,
      value: value
    }
    Card.new(card_details)
  end

  def reset_deck(cards)
    in_deck_cards.concat(cards)
    shuffle
  end
end

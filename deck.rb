 # - Card class takes a hash of card attributes and assigns them to instance variables that are attr_reader
 # - Deck class builds a deck using the Card class, will have various methods for manipulating the deck, the actual cards will be attr_reader and modified through methods.


class Card

  attr_reader :name, :group, :colour, :value, :icon

  def initialize(details)
    @name = details[:name]
    @group = details[:group]
    @colour = details[:colour]
    @value = details[:value]
    @icon = name.to_s[0].upcase
  end

  def display
    "#{icon} #{group}"
  end
end

class Deck

  attr_reader :in_deck_cards, :out_of_deck_cards, :groups

  def initialize
    @in_deck_cards = []
    @out_of_deck_cards = []
    @groups = ["hearts", "diamonds", "spades", "clubs"]
  end

  def build_standard_deck
    @groups.each do |group|
      colour = if @groups.index(group) < 2
        "red"
      else
        "black"
      end
      build_number_cards(group, colour)
      build_royal_cards(group, colour)
    end
  end

  def build_royal_cards(group, colour)
    ["jack", "queen", "king"].each do |card|
      top_deck_card(build_card(group, colour, card, 10))
    end
  end

  def build_number_cards(group, colour)
    (1..10).to_a.each do |num|
      name = num > 1 ? num : "ace"
      top_deck_card(build_card(group, colour, name, num))
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

  def shuffle
    in_deck_cards.shuffle!
  end

  def reset_deck
    in_deck_cards.concat(out_of_deck_cards)
    shuffle
  end
end

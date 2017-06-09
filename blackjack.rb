require './deck'
require './player'

# This will build a deck through the deck class and run through a game of BlackJack
# - Use Deck class to manage deck and cards
# - Use Player class to keep track of hands and score
# - Manage custom rules (like allowing ace to be 11 or 1)
# - Will need a loop to manage rounds and give the player the option to leave/continue. If continue need to account for when deck is nearly empty.
# - Create simple AI for the dealer, when to hit, and when to stay

class BlackJackPlayer < Player
  def total_points
    total = raw_total
    ace = cards.find{|card| card.name == "Ace"}
    if total < 12 && !ace.nil?
      puts "You have at least one ace, if you hit and go over 21 it will be counted as a 1." unless name == "Dealer"
      total += 10
    end
    total
  end

  def raw_total
    cards.inject(0){|sum, card| sum + card.value}
  end

  def bust?
    total_points > 21
  end
end

class BlackJack
  attr_reader :deck, :player, :dealer, :end_game, :round

  def initialize
    @deck = Deck.new
    @player = BlackJackPlayer.new
    @dealer = BlackJackPlayer.new
    @round = 0
    @end_game = false
  end

  def start_game
    puts "Please enter your name"
    player.set_name(gets.chomp)
    deck.build_standard_deck
    deck.shuffle
    begin_rounds
  end

  private

  def begin_rounds
    until end_game
      @round += 1
      [player, dealer].each {|user| user.discard_hand}
      deal_cards
      players_choices
      dealers_choices
      end_round
    end
  end

  def deal_cards
    puts "Beginning round #{round}"
    dealer.add_cards_to_hand(deck.draw(2))
    puts "The dealers visible card is #{dealer.cards.sample.display}"
    player.add_cards_to_hand(deck.draw(2))
  end

  def players_choices
    player.show_hand
    if player.bust?
      puts "#{player.name} has gone bust with #{player.total_points}."
      return
    end
    puts "It's your turn #{player.name}, your current total is #{player.total_points}"
    puts "Would you like to hit or stand?"
    handle_player_response(gets.chomp.downcase)
  end

  def handle_player_response(response)
    return if response == "stand"
    if response == "hit"
      card = deck.draw
      player.add_cards_to_hand(card)
      puts "You draw a #{card[0].display}"
    end
    players_choices
  end

  def dealers_choices
    dealer.show_hand
    if dealer.bust?
      puts "#{dealer.name} has gone bust with #{dealer.total_points}."
      return
    end
    puts "Dealer's current total is #{dealer.total_points}"
    handle_dealers_decisions
  end

  def handle_dealers_decisions
    if dealer.total_points < 17 && !player.bust?
      card = deck.draw
      dealer.add_cards_to_hand(card)
      puts "The dealer hits and draws #{card[0].display}"
      dealers_choices
    end
  end

  def end_round
    winner = if !player.bust? && !dealer.bust? && dealer.total_points == player.total_points
      [dealer, player]
    else
      (player.bust? || dealer.total_points > player.total_points) ? dealer : player
    end
    handle_victory(winner)
    play_another_round
  end

  def handle_victory(winner)
    if winner.class.name == "Array"
      puts "It was a TIE, both parties gain 1 point"
      winner.each {|x| x.change_score(1)}
    else
      puts "#####################"
      puts "#{winner.name.upcase} is the winner and gains 3 points"
      puts "#####################"
      winner.change_score(3)
    end
  end

  def play_another_round
    puts "Would you like to play another round? (yes or no)"
    response = gets.chomp.downcase
    if response == "yes"
      puts "End of round #{round}"
      puts " ---- "
    else
      puts "The overall winner is #{find_winner}"
      @end_game = true
    end
  end

  def find_winner
    (!dealer.bust? && dealer.score > player.score) ? dealer.name : player.name
  end
end

bj = BlackJack.new
bj.start_game

# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new('Josiane')
player2 = Player.new('José')

while (player1.life_points > 0) && (player2.life_points > 0)
  puts "\n Voici l'état de nos joueurs :"

  player1.show_state
  player2.show_state

  puts "\n\nPassons à la phase d'attaque"

  player1.attacks(player2)
  break if player2.life_points <= 0
  player2.attacks(player1)

  puts '------------------------------'
end

player1.life_points <= 0 ? (puts "\n#{player2.name} a gagné") : (puts "\n#{player1.name} a gagné\n")

binding.pry

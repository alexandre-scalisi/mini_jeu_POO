# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'
def afficher_etat(player1, player2)
  puts
  puts "\n Voici l'état de nos joueurs :"
  puts

  player1.show_state
  player2.show_state
end

def phase_attaque(player1, player2)
  puts "\n Passons à la phase d'attaque"
  puts
  player1.attacks(player2)
  return if player2.life_points <= 0
  player2.attacks(player1)
end

def game
  player1 = Player.new('Josiane')
  player2 = Player.new('José')

  while (player1.life_points > 0) && (player2.life_points > 0)
    afficher_etat(player1, player2)
    phase_attaque(player1, player2)

    puts '----------------------------------------'
    gets # appuyez sur entrée c'est juste pour pas que ça défile

  end
  fin(player1, player2)
end

def fin(player1, player2)
  player1.life_points <= 0 ? (puts "\n#{player2.name} a gagné") : (puts "\n#{player1.name} a gagné\n")
end

game

# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def affichage_bienvenue
  puts
  "------------------------------------------------
  |Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
  |Le but du jeu est d'être le dernier survivant !|
  -------------------------------------------------"
end

def inputs
  puts "\nQuel est ton nom?"
  print '> '
  gets.chomp
end

def game(nom)
  game = Game.new(nom)

  while game.is_still_going?
    game.show_players
    puts
    game.new_players_in_sight
    game.menu

    break unless game.is_still_going?
    next if game.enemies_in_sight.length.zero?
    puts "\nLes autres joueurs t'attaquent !\n\n"

    game.enemies_attack

    puts '----------------------------------------'
    gets # appuyez sur entrée c'est juste pour pas que ça défile
  end
end

def perform
  affichage_bienvenue
  nom = inputs
  game(nom)
  game.end
end

perform

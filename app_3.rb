# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts (
"------------------------------------------------
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------")
  
puts "\nQuel est ton nom?"
print '> '
nom = gets.chomp
game = Game.new(nom)
while game.is_still_going?
  puts game.human_player.show_state
  game.menu
  break if !game.is_still_going?
  puts "\nLes autres joueurs t'attaquent !"

  game.enemies_attack

  puts "----------------------------------------"
  gets #appuyez sur entrée c'est juste pour pas que ça défile
end

game.end
binding.pry
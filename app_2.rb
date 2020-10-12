# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def menu(humain, player1, player2)
  loop do
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"

    puts "attaquer un joueur en vue :\n\n"
    print '0 - '
    player1.show_state
    print '1 - '
    player2.show_state

    print '> '
    input = gets.chomp
    case input
    when 'a' then humain.search_weapon; break

    when 's' then humain.search_health_pack; break

    when '0' then humain.attacks(player1); break

    when '1' then humain.attacks(player2); break

    end
    puts "\n----------------------------------------"
  end
  puts "\n----------------------------------------"
end

puts (
"------------------------------------------------
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------")

puts "\nQuel est ton nom?"
print '> '
nom = gets.chomp
human1 = HumanPlayer.new(nom)
puts "Humain #{nom} créé!"
enemies = []
player1 = Player.new('Josiane')
player2 = Player.new('José')
enemies.push(player1, player2)

while human1.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
  puts human1.show_state
  menu(human1, player1, player2)
  break if player1.life_points <= 0 && player2.life_points <= 0
  puts "Les autres joueurs t'attaquent !"
  enemies.each do |p|
    break if human1.life_points <= 0
    p.attacks(human1) if (p.life_points > 0)
    
    puts
  end
  puts "----------------------------------------"
  gets #appuyez sur entrée c'est juste pour pas que ça défile
end

puts "Fini"
human1.life_points > 0 ? (puts "Vous avez gagné") : (puts "Vous avez perdu")

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

def initialiser_humain
  puts 'Quel est ton nom?'
  print '> '
  nom = gets.chomp
  human1 = HumanPlayer.new(nom)
  puts "Humain #{nom} créé!"
  human1
end

def initialiser_ennemis
  enemies = []
  player1 = Player.new('Josiane')
  player2 = Player.new('José')
  enemies.push(player1, player2)
  enemies
end

def menu_affichage(human1, enemies)
  loop do
    puts 'a - chercher une meilleure arme'
    puts 's - chercher à se soigner'

    unless enemies.empty?
      puts "\nattaquer un joueur en vue :\n\n"

      enemies.each_with_index do |enemie, i|
        print "#{i} - "
        enemie.show_state
      end
    end

    stop = menu_choix(human1, enemies)
    puts "\n----------------------------------------"
    break if stop
  end
end

def menu_choix(human1, enemies)
  print '> '
  choice = gets.chomp

  if choice == 'a'
    human1.search_weapon
    true

  elsif choice == 's'
    human1.search_health_pack
    true

  elsif choice != '' && (choice.ord == 48 || (choice.to_i > 0 && choice.to_i < enemies.length))
    attacked_enemie = enemies[choice.to_i]
    human1.attacks(attacked_enemie)
    enemies.delete(attacked_enemie) if attacked_enemie.life_points <= 0
    true
  end
end

def attacks(human1, enemies)
  puts "Les autres joueurs t'attaquent !"
  enemies.each do |p|
    break if human1.life_points <= 0
    p.attacks(human1)

    puts
  end
  puts '----------------------------------------'
  gets # appuyez sur entrée c'est juste pour pas que ça défile
end

def fin(human1)
  puts 'Fini'
  human1.life_points > 0 ? (puts 'Vous avez gagné') : (puts 'Vous avez perdu')
end

def game
  affichage_bienvenue
  human1 = initialiser_humain
  enemies = initialiser_ennemis
  while human1.life_points > 0 && !enemies.empty?
    puts human1.show_state
    menu_affichage(human1, enemies)
    break if enemies.empty?
    attacks(human1, enemies)
  end
  fin(human1)
end

game

# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


#Methode qui souhaite la bienvenue aux joueurs
def affichage_bienvenue
puts"------------------------------------------------
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------"
end

#La methode permet d'instancier un HumanPlayer
def initialiser_humain
  puts 'Quel est ton nom?'
  print '> '
  nom = gets.chomp
  human1 = HumanPlayer.new(nom)
  puts "Humain #{nom} créé!"
  human1
end

#La methode permet de créer deux Players que l'on met dans un array ennemies
def initialiser_ennemis
  enemies = []
  player1 = Player.new('Josiane')
  player2 = Player.new('José')
  enemies.push(player1, player2)
  enemies
end

#Cette méthode permet d'afficher un menu qui donne
#à l'utilisateur les touches pour éffectuer des actions
def menu_affichage(human1, enemies)
  loop do                                                     #On fait une loop jusqu'a avoir une input correcte
    puts 'a - chercher une meilleure arme'
    puts 's - chercher à se soigner'

    unless enemies.empty?                                     #si l'array d'ennemis n'est pas vide, les ennemis attaquent
      puts "\nattaquer un joueur en vue :\n\n"

      enemies.each_with_index do |enemy, i|                  #On montre l'état de chaque ennemi
        print "#{i} - "
        enemy.show_state
      end
    end

    stop = menu_choix(human1, enemies)                       #On appelle la methode menu_choix, si elle retourne true on quitte la boucle
    puts "\n----------------------------------------"        #Sinon on refait un tour de boucle
    break if stop
  end
end

#Cette méthode récupere les inputs de l'utilisateur 
#et fait les actions du menu_affichage
def menu_choix(human1, enemies)
  print '> '
  choice = gets.chomp                     #On stock l'input de l'utilisateur dans une variable "choice"

  if choice == 'a'
    human1.search_weapon
    true

  elsif choice == 's'
    human1.search_health_pack
    true

  elsif choice != '' && (choice.ord == 48 || (choice.to_i > 0 && choice.to_i < enemies.length))  #Si l'input est un nombre entre 0 et le nombre d'ennemis-1,
                                                                                                 #on attaque l'ennemis n°input et on vérifie que l'input n'est pas vide 
                                                                                                 #sinon l'input est true pour input==0
    attacked_enemy = enemies[choice.to_i]
    human1.attacks(attacked_enemy)
    enemies.delete(attacked_enemy) if attacked_enemy.life_points <= 0
    true
  end
end

#Cette methode fais attaquer les ennemis
def attacks(human1, enemies)
  puts "Les autres joueurs t'attaquent !"
  enemies.each do |p|                             #chaque ennemi attaque l'humain, si l'humain meurt on quitte avant
    break if human1.life_points <= 0
    p.attacks(human1)

    puts
  end
  puts '----------------------------------------'
  gets # appuyez sur entrée c'est juste pour pas que ça défile
end

#Cette methode annonce la fin du jeu et le gagnant
def fin(human1)
  puts 'Fini'
  human1.life_points > 0 ? (puts 'Vous avez gagné') : (puts 'Vous avez perdu')
end

#Methode principale qui créer la partie
def game
  affichage_bienvenue
  human1 = initialiser_humain
  enemies = initialiser_ennemis
  while human1.life_points > 0 && !enemies.empty?        #Temps que l'humain et vivant ou qu'il reste au moins un ennemi vivant, les joueurs se combattent
    puts human1.show_state
    menu_affichage(human1, enemies)
    break if enemies.empty?                              #S'il n'y a plus d'ennemis la partie est finie
    attacks(human1, enemies)
  end
  fin(human1)
end

game                                                     #appel à la methode principale(game) pour lancer le jeu

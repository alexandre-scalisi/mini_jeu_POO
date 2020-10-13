# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

#La methode souhaite la bienvenue à l'utilisateur
def affichage_bienvenue
puts"------------------------------------------------
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------"
end


#La methode instantie un objet Game
def create_game
  puts "\nQuel est ton nom?"                #L'utilisateur rentre un nom qu'on rentre 
  print '> '                                #dans le constructeur d'un objet Game
  nom = gets.chomp
  Game.new(nom)
end

#Methode principale qui créer la partie
def game_method
  affichage_bienvenue
  game = create_game
  while game.is_still_going?                                    #tant que la méthode is_still_going renvoie true, on continue le jeu
    
    game.show_players                                                   
    puts
    game.new_players_in_sight
    game.menu

    break unless game.is_still_going?                          #si la méthode is_still_going ne renvoie plus true, la partie est terminée

    next if game.enemies_in_sight.length.zero?                 #on passe au prochain tour de boucle s'il n'y a pas d'ennemis en vue
    puts "\nLes autres joueurs t'attaquent !\n\n"

    game.enemies_attack

    puts '----------------------------------------'
    gets # appuyez sur entrée c'est juste pour pas que ça défile
  end
  game.end          
end

game_method        #appel à la methode principale (game_method) pour lancer le jeu

# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'                   
require_relative 'lib/player'

#Méthode qui permet d'afficher l'état des deux joueurs
def afficher_etat(player1, player2)
  puts
  puts "\n Voici l'état de nos joueurs :"      
  puts

  player1.show_state                                                #On affiche l'etat des joueurs grace à la methode show_state 
  player2.show_state                                                #de la classe Player         
end


#Méthode qui s'occupe d'éffectuer la phase d'atttaque
def phase_attaque(player1, player2)
  puts "\n Passons à la phase d'attaque"
  puts
  player1.attacks(player2)
  return if player2.life_points <= 0                                #Si le player2 est mort on quitte la fonction
  player2.attacks(player1)
end

#Méthode qui indique la fin du jeu et le gagnant
def fin(player1, player2)
  puts "Fin du jeu"
  player1.life_points <= 0 ? (puts "\n#{player2.name} a gagné") : (puts "\n#{player1.name} a gagné\n")
end


#Methode principale qui créer la partie
def game
  player1 = Player.new('Josiane')                                   #On créer nos 2 joueurs grace au constructeur de la classe Player  
  player2 = Player.new('José')

  while (player1.life_points > 0) && (player2.life_points > 0)     #Temps que l'un des joueurs est en vie, on affiche leur état                                                                  
    afficher_etat(player1, player2)                                #puis ils s'attaquent entre eux
    phase_attaque(player1, player2)

    puts '----------------------------------------'
    gets                                                           # appuyez sur entrée c'est juste pour pas que ça défile

  end
  fin(player1, player2)                                           
end

game                                                              # On lance la méthode game qui s'occupera du reste

class Game
  attr_accessor :human_player, :enemies_in_sight, :players_left
  def initialize(human_player)
    @human_player = HumanPlayer.new(human_player)  #On instantie un HumanPLayer qui aura pour nom ce qu'on a mit en argument dans le constructeur
    @enemies_in_sight = []
    @players_left = 10
  end

  def kill_player(player) 
    @enemies_in_sight.delete(player) 
    @players_left -= 1
  end

  def is_still_going?
    @human_player.life_points > 0 && @players_left > 0
  end

  def show_players
    @human_player.show_state
    puts "Il reste #{@players_left} ennemis dont #{@enemies_in_sight.length} en vue"
  end

  #Comme dans l'app_2
  def menu
    loop do
      puts 'a - chercher une meilleure arme'
      puts 's - chercher à se soigner'

      unless @enemies_in_sight.empty?
        puts "\nattaquer un joueur en vue :\n\n"                      

        @enemies_in_sight.each_with_index do |enemie, i|
          print "#{i} - "
          enemie.show_state
        end
      end

      stop = menu_choice
      puts "\n----------------------------------------"
      break if stop
    end
  end

  #Comme dans l'app_2
  def menu_choice
    print '> '
    choice = gets.chomp

    if choice == 'a'
      @human_player.search_weapon
      true

    elsif choice == 's'
      @human_player.search_health_pack
      true

    elsif choice != "" && (choice.ord == 48 || (choice.to_i > 0 && choice.to_i < @enemies_in_sight.length))
      attacked_enemie = @enemies_in_sight[choice.to_i]
      @human_player.attacks(attacked_enemie)
      kill_player(attacked_enemie) if attacked_enemie.life_points <= 0
      true
    end
  end

  def enemies_attack
    @enemies_in_sight.each do |p|
      break if @human_player.life_points <= 0
      p.attacks(@human_player)

      puts
    end
  end

  def new_players_in_sight
    if @players_left == @enemies_in_sight.length
      puts 'Tous les joueurs sont déjà en vue'             
      return
    end
    de = rand(1..6)

    if de == 1
      puts 'Pas de nouveau joueur adverse'
    elsif (de >= 2 && de <= 4) || (@enemies_in_sight.length + 2 > @players_left)
      puts 'Un nouveau joueur arrive'
      @enemies_in_sight << Player.new("Player#{rand(0..9_999_999_999_999)}")
    else
      puts 'Deux nouveaux joueurs arrivent'
      @enemies_in_sight.push(Player.new("Player#{rand(0..9_999_999_999_999)}"), Player.new("Player#{rand(0..9_999_999_999_999)}"))

    end
  end

  def end
    puts 'Fini'
    @human_player.life_points > 0 ? (puts 'Vous avez gagné') : (puts 'Vous avez perdu')
  end
end
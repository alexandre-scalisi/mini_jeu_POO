# frozen_string_literal: true

class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @life_points = 10
    @name = name
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie"
  end

  def attacks(player)
    puts "#{@name} attaque #{player.name}"
    dmg = compute_damage
    puts "il lui inflige #{dmg} points de dommages"
    player.gets_damage(dmg)
  end

  def gets_damage(dmg)
    @life_points -= dmg
    puts "#{@name} a été tué" if @life_points <= 0
  end

  private def compute_damage
    rand(1..6)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level
  def initialize(name)
    @name = name
    @weapon_level = 1
    @life_points = 100
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{weapon_level}"
  end

  def compute_damage
    super * @weapon_level
  end

  def search_weapon
    nv_arme_trouvee = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{nv_arme_trouvee}"
    if nv_arme_trouvee > @weapon_level
      @weapon_level = nv_arme_trouvee
      puts 'Youhou ! elle est meilleure que ton arme actuelle : tu la prends.'
    else
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  def search_health_pack
    pack_pts_vie = rand(1..6)

    case pack_pts_vie

    when 1 then puts "Tu n'as rien trouvé..."

    when (2..5)
      if @life_points < 50
        @life_points += 50
      else
        @life_points = 100
      end
      puts 'Bravo, tu as trouvé un pack de +50 points de vie !'

    when 6
      if @life_points < 80
        @life_points += 80
      else
        @life_points = 100
      end
      puts 'Waow, tu as trouvé un pack de +80 points de vie !'
    end
  end

end

class Game

  attr_accessor :human_player, :enemies, :players_left, :enemies_in_sight
  def initialize(human_player)
    @human_player = HumanPlayer.new(human_player.to_s)
    @enemies = []
    (1..4).each {|p| @enemies<< Player.new("player#{p}")}
    
  end

  def kill_player(player)
    @enemies.delete(player)
    
  end

  def is_still_going?
    @human_player.life_points > 0 && @enemies.length > 0
  end

  def show_players
    @human_player.show_state
    puts "Il reste #{@enemies.length} ennemis"
  end

  def menu()
    loop do
      
      puts "a - chercher une meilleure arme"
      puts "s - chercher à se soigner"
  
      puts "attaquer un joueur en vue :\n\n"
      
      @enemies.each_with_index do |enemie,i|
      print "#{i} - "
      enemie.show_state
      end
      print "> "
      input = gets.chomp
      stop = menu_choice(input)
      puts "\n----------------------------------------"
      break if stop
    end
  end

  def menu_choice(choice)
      
        
        if choice == "a"
          @human_player.search_weapon
          return true
    
        elsif choice == "s" 
          @human_player.search_health_pack
          return true
    
        elsif (choice.to_i) >=0 && (choice.to_i) < @enemies.length
          attacked_enemie = @enemies[choice.to_i]
          @human_player.attacks(attacked_enemie)
          kill_player(attacked_enemie) if attacked_enemie.life_points <= 0 
          return true
        end
        
    
  end

  def enemies_attack
    @enemies.each do |p|
      break if @human_player.life_points <= 0
      p.attacks(@human_player)
      
      puts
    end
  end

  def end
    puts "Fini"
    @human_player.life_points > 0 ? (puts "Vous avez gagné") : (puts "Vous avez perdu")
  end
    
  
end

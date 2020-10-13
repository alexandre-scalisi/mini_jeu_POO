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
    rand(1..6)              #renvoi un nombre aléatoire entre 1 et 6 inclus
  end
end

class HumanPlayer < Player        #HumanPLayer hérite de Player
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
    super * @weapon_level  #on appelle la méthode de Player à laquelle on multiplie notre weapon_level
  end

  def search_weapon
    nv_arme_trouvee = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{nv_arme_trouvee}"
    if nv_arme_trouvee > @weapon_level
      @weapon_level = nv_arme_trouvee
      puts 'Youhou ! elle est meilleure que ton arme actuelle : tu la prends.'
    else
      puts "M@*edks.. elle n'est pas mieux que ton arme actuelle..."
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

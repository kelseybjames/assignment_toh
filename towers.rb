class TowerOfHanoi
  def initialize(disks)
    @disks = disks
    game_map = [(1..disks), [], []]
  end

  def move(coordinates)
    raise ArgumentError, "Argument is not an array" unless coordinates.is_a?(Array)
    raise ArgumentError, "Please input numbers" unless coordinates[0].is_a?(Numeric) && coordinates[1].is_a?(Numeric)
    raise ArgumentError "Please input valid coordinates" unless (1..3).include? coordinates[0] && (1..3).include? coordinates[1]
    raise ArgumentError, "Please give a start and end point" unless coordinates.length == 2
    raise ArgumentError "That move is not allowed" unless game_map[coordinates[0]-1][0] < game_map[coordinates[1]-1][0] || game_map[coordinates[1]-1][0] == nil

    moving_disk = game_map[coordinates[0]-1].shift
    game_map[coordinates[1]-1].unshift(moving_disk)
  end

  def render(board)
    
  end

  def play
    puts "Welcome to Tower of Hanoi!"
    while game_map != [[], (1..disks), []] && game_map != [[], [], (1..disks)]
      puts "Enter where you'd like to move from and to in the format [1,3]. Enter 'q' to quit."
      input = gets.chomp
      if input = "q"
        break
      else
        current_move = [input[1].to_i, input[3].to_i]
        move(current_move)
      end
      render(game_map)
    end
  end
end
class TowerOfHanoi
  attr_accessor :game_map

  def initialize(disks)
    @disks = disks
    @game_map = [(1..disks).to_a, Array.new(disks) {0}, Array.new(disks) {0}]
  end

  def nonzero_min(array)
    nonzero = array - [0]
    nonzero.min
  end

  def height(column)
    nonzero = @game_map[column] - [0]
    nonzero.length
  end

  def move(coordinates)
    origin_post = coordinates[0] - 1
    destination_post = coordinates[1] - 1
    moving_disk = @game_map[origin_post][@disks-height(origin_post)]

    raise Exception.new("Argument is not an array") unless coordinates.is_a?(Array)
    raise Exception.new("Please input numbers") unless coordinates[0].is_a?(Numeric) && coordinates[1].is_a?(Numeric)
    raise Exception.new("Please input valid coordinates") unless ((1..3).include? coordinates[0]) && ((1..3).include? coordinates[1])
    raise Exception.new("Please give a start and end point") unless coordinates.length == 2
    raise Exception.new("That move is not allowed") unless nonzero_min(@game_map[destination_post]) == nil || moving_disk < nonzero_min(@game_map[destination_post])

    # Leaving the origin
    @game_map[origin_post][@disks-(height(origin_post))] = 0

    # Arriving at its destination
    @game_map[destination_post][@disks-(height(destination_post)+1)] = moving_disk
  end

  def render(board)
    rows = Array.new(@disks) {[]}

    # Convert columns to rows
    (0..@disks-1).each do |row|
      rows[row] << @game_map[0][row]
      rows[row] << @game_map[1][row]
      rows[row] << @game_map[2][row]
    end

    # puts each row one at a time
    rows.each do |row|
      row.each do |column|
        disk_display = "o"*column
        print disk_display
        print " "*(@disks - disk_display.length + 1)
      end
      print "\n"
    end

    # Column numbers
    puts "1" + (" " * @disks) + "2" + (" " * @disks) + "3"
  end

  def play
    puts "Welcome to Tower of Hanoi!"
    while @game_map != [Array.new(@disks) {0}, (1..@disks).to_a, Array.new(@disks) {0}] && @game_map != [Array.new(@disks) {0}, Array.new(@disks) {0}, (1..@disks).to_a]
      render(game_map)
      puts "Enter where you'd like to move from and to in the format [1,3]. Enter 'q' to quit."
      input = gets.chomp
      if input == "q"
        break
      else
        current_move = [input[1].to_i, input[3].to_i]
        move(current_move)
      end
    end
    puts "Congratulations, you won!"
  end
end
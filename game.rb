# A rock, paper scissors console game in OOP Ruby

class Computer
  def get_selection
    rand(0..2)
  end
end

class Player
  attr_accessor :keep_playing
  
  def initialize
    @keep_playing = true
  end
  
  # gets the player's game move and convert it to an integer
  # output: an integer representing the game move
  def get_selection()
    # maps the user character input to a an integer
    play_num = {'r' => 0, 'p' => 1, 's' => 2 }
      
    # flag to make sure user selection is valid
    valid_user_selection = false
    begin
      # Prompt user for selection
      puts "Choose one: (P/R/S)"
      
      # get selection from user
      user_selection = gets.chomp
      if(user_selection =~ /^[PpRrSs]$/)
        user_selection = user_selection.downcase
        valid_user_selection = true
      else
        puts "Invalid Selection: #{user_selection}. Please try again."
      end
    end while valid_user_selection == false
    
    return play_num[user_selection]  
  end
  
  # gets input from player to determine if they want to continue playing
  # outputs: true to keep playing or false to quit
  def play_again?()
    # keep playing unless user enters 'y' to quit
      puts "Play again? (Y/N)"
      @keep_playing = false if gets.chomp.downcase != 'y'  
    return @keep_playing
  end
end

class Game

  def initialize(player, computer)
    @player = player
    @computer = computer
  end
  
  
  # determines who won the game
  # inputs: integers representing game choices for p_choice, c_choice
  # output: a string representing the outcome based upon the rules of RPS
  def who_won(p_choice, c_choice)
    # array of RPS actions
    win_rps = ['Rock crushes Scissors!', 'Paper wraps Rock!', 'Scissors cuts paper!']
    if(p_choice == c_choice) # player and computer picked same thing so it's a tie
      puts "It's a tie."
    elsif((p_choice==0 && c_choice==2) || (p_choice==1 && c_choice==0) || (p_choice==2 && c_choice==1)) #player win conditions
      puts win_rps[p_choice]
      puts "You won!"
    else #if not a tie and player didn't win then computer must win
      puts win_rps[c_choice]
      puts "Computer won!"
    end
  end

  # main play method
  # outputs: fun!
  def play()
    # Array of possible choices in RPS
    rps = ['Rock', 'Paper', 'Scissors']
    
    # Welcome message
    puts "Play Paper Rock Scissors!"
    
    # main game loop
    begin     
      user_selection = @player.get_selection

      # get the computer's random pick
      computer_selection = @computer.get_selection
      
      puts "You picked #{rps[user_selection]} and computer picked #{rps[computer_selection]}."
      
      # determine outcome
      who_won(user_selection, computer_selection)

      # determine if we should keep playing
      keep_playing = @player.play_again?

    end while keep_playing == true
  end
end

# let's play the game!
player = Player.new
computer = Computer.new
game = Game.new(player, computer)
game.play()
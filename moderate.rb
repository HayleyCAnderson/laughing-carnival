puts "17.2"
# Design an alogorithm to figure out if someone has won a game of tic-tac-toe.

def winner(board)
  streaks = []

  # check rows
  board.each do |row|
    streaks << streak(row)
  end

  # check columns
  (0..3).each do |i|
    column = []
    board.each do |row|
      column << row[i]
    end
    streaks << streak(column)
  end

  # check diagonals
  diagonal = []
  reverse_diagonal = []
  (0..2).each do |i|
    diagonal << board[i][i]
    reverse_diagonal << board[i][2 - i]
  end
  streaks << streak(diagonal)
  streaks << streak(reverse_diagonal)

  # return decisive winner or nil
  potential_winners = streaks.compact.uniq
  if potential_winners.length == 1
    potential_winners.first
  else
    nil
  end
end

def streak(series)
  if series.count("X") == 3
    "X"
  elsif series.count("O") == 3
    "O"
  end
end

board = [["X", "O", "X"], ["O", "X", "O"], ["X", "O", "X"]]
puts winner(board) == "X"
board = [["X", "", "X"], ["O", "O", "O"], ["X", "", "X"]]
puts winner(board) == "O"
board = [["X", "X", "X"], ["O", "X", "O"], ["O", "O", "O"]]
puts winner(board) == nil
board = [["", "O", ""], ["O", "", "O"], ["X", "", "X"]]
puts winner(board) == nil
board = [["", "", ""], ["", "", ""], ["", "", ""]]
puts winner(board) == nil
board = [["X", "O", "X"], ["X", "O", "O"], ["X", "", "X"]]
puts winner(board) == "X"
board = [["X", "O", "X"], ["O", "X", "O"], ["X", "", "O"]]
puts winner(board) == "X"

puts "17.5"
# Game of Master Mind

def master_mind(solution, guess)
  hits = {"R" => 0, "Y" => 0, "G" => 0, "B" => 0}
  pseudo_hits = {"R" => 0, "Y" => 0, "G" => 0, "B" => 0}

  solution_arr = solution.split("")
  guess_arr = guess.split("")

  # check hits
  solution_arr.each_with_index do |char, i|
    if guess_arr[i] == char
      hits[char] += 1
    end
  end

  # check pseudo hits
  guess_arr.each do |char|
    if solution_arr.include?(char) && pseudo_hits[char] == 0 && hits[char] == 0
      pseudo_hits[char] += 1
    end
  end

  hits_sum = 0
  pseudo_hits_sum = 0
  hits.values.each { |i| hits_sum += i}
  pseudo_hits.values.each { |i| pseudo_hits_sum += i}

  {hits: hits_sum, pseudo_hits: pseudo_hits_sum}
end

puts master_mind("RGBY", "GGRR") == {hits: 1, pseudo_hits: 1}

puts "17.6"
# Given an array of integers, write a method to find indices m and n such that
# if you sorted elements m through n, the entire array would be sorted. Minimize
# n - m (that is, find the smallest such sequence).

def needs_sorting_indices(arr)
  min_index = nil
  max_index = nil

  arr.each_with_index do |int, index|
    arr.each_with_index do |loop_int, loop_index|
      # find min index
      if int < loop_int && index > loop_index
        if !min_index || loop_index < min_index
          min_index = loop_index
        end
      end

      # find max index
      if int > loop_int && index < loop_index
        if !max_index || loop_index > max_index
          max_index = loop_index
        end
      end
    end
  end

  [min_index, max_index]
end

arr = [1, 2, 4, 7, 10, 11, 7, 12, 6, 7, 16, 18, 19]
puts needs_sorting_indices(arr) == [3, 9]
puts needs_sorting_indices([2, 1, 5, 3, 7, 9]) == [0, 3]
puts needs_sorting_indices([1, 5, 3, 7, 9, 2]) == [1, 5]


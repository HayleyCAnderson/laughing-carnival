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

puts "17.7"
#Given any integer, print an English phrase that describes the integer.

ONES = {
  0 => nil,
  1 => "one",
  2 => "two",
  3 => "three",
  4 => "four",
  5 => "five",
  6 => "six",
  7 => "seven",
  8 => "eight",
  9 => "nine"
}

TEENS = {
  0 => "ten",
  1 => "eleven",
  2 => "twelve",
  3 => "thirteen",
  4 => "fourteen",
  5 => "fifteen",
  6 => "sixteen",
  7 => "seventeen",
  8 => "eighteen",
  9 => "nineteen"
}

TENS = {
  2 => "twenty",
  3 => "thirty",
  4 => "forty",
  5 => "fifty",
  6 => "sixty",
  7 => "seventy",
  8 => "eighty",
  9 => "ninety"
}

DIGITS = {
  1 => nil,
  3 => "hundred",
  4 => "thousand",
  7 => "million",
  10 => "billion"
}

def spell_out(integer)
  #print integer
  ints = integer.to_s.split("")
  prev_int = nil
  words = []

  return if ints.length > DIGITS.keys.last

  ints.each_with_index do |i, index|
    int = i.to_i
    digit = ints.length - index

    if DIGITS.keys.include?(digit)
      double = spell_double(prev_int, int)
      spelled_digit = DIGITS[digit]
      if double
        words << double
        words << spelled_digit if spelled_digit
      end
      prev_int = nil
    else
      prev_int = int
    end
  end

  words << "zero" if words.empty?
  #print words
  words.join(" ").rstrip
end

def spell_double(int_one, int_two)
  if !int_one || int_one == 0
    ONES[int_two]
  elsif int_one == 1
    TEENS[int_two]
  elsif int_two == 0
    TENS[int_one]
  else
    TENS[int_one] + " " + ONES[int_two]
  end
end

puts spell_out(1234) == "one thousand two hundred thirty four"
puts spell_out(430) == "four hundred thirty"
puts spell_out(23) == "twenty three"
puts spell_out(12) == "twelve"
puts spell_out(2) == "two"
puts spell_out(100000) == "one hundred thousand"
puts spell_out(102000) == "one hundred two thousand"
puts spell_out(30000000) == "thirty million"
puts spell_out(0) == "zero"
puts spell_out(10000000000) == nil
puts spell_out(-10) == "negative ten"
# I have fucked up

puts "17.8"
# You are given an array of integers (both positive and negative). Find the
# contiguous sequence with the largest sum. Return the sum.

Window = Struct.new(:start_index, :end_index, :sum)

def max_contiguous_sum(arr)
  windows = {}
  max_window = nil

  arr.each_with_index do |i, index|
    (arr.length - index).times do |t|
      end_index = index + t

      if windows[index]
        sum = windows[index].last.sum + arr[end_index]
        window = Window.new(index, end_index, sum)
        windows[index] << window
      else
        sum = arr[index..end_index].inject { |result, int| result + int }
        window = Window.new(index, end_index, sum)
        windows[index] = [window]
      end

      max_window = window if !max_window || window.sum > max_window.sum
    end
  end

  max_window ? max_window.sum : 0
end

puts max_contiguous_sum([2, -8, 3, -2, 4, -10]) == 5
puts max_contiguous_sum([2, 8, 3, 2, 4, 10]) == 29
puts max_contiguous_sum([-2, -8, 3, -2, -4, -10]) == 3
puts max_contiguous_sum([-1]) == -1
puts max_contiguous_sum([]) == 0

puts "17.9"
# Design a method to find the frequency of occurrences of any given word in a
# book.


=begin
This is intentionally over-engineered in order to brush up on my rusty Ruby. It
is a solution to this problem, which I wrote:

A Caesar, or shift, cipher is one of the simplest types of encryption. It takes a string of characters and replaces each character with another character a given number of characters further in the alphabet. Here assume use of only the 26-character Latin alphabet. For example, HAYLEY with a shift of 3 becomes KDBOHB.

1. Write some code that allows submission of a numeric shift value and a string to be encrypted and returns the encrypted version of the string.

2. Write some code that takes a potentially shift-encrypted string and returns every possible shift and potentially decrypted string (26 results).
=end

module Alphabet
  ALPHABET = ('A'..'Z').to_a
  ALPHABET_KEY = ALPHABET.map.with_index { |c, i| [c, i] }.to_h
end

class Shifter
  include Alphabet

  def initialize(key)
    raise ShiftKeyError if (key.class != Fixnum || key > 26 || key < 0)
    @key = key
  end

  def shift(input)
    result = ""
    input.to_s.upcase.each_char do |char|
      result << shift_char(char)
    end
    result
  end

  private

  def shift_char(char)
    index = ALPHABET_KEY[char]
    return char unless index
    shifted_index = index + @key
    shifted_index -= ALPHABET.length if shifted_index >= ALPHABET.length
    ALPHABET[shifted_index]
  end
end

class Unshifter
  include Alphabet

  def unshift(input)
    results = {}
    (0..ALPHABET.length).to_a.each do |key|
      result = Shifter.new(key).shift(input)
      results[ALPHABET.length - key] = result
    end
    results
  end
end

class ShiftKeyError < StandardError
  def initialize
    super("Shift keys must be an integer between 0 and 26.")
  end
end

class Tester
  class << self
    def test_key(key, expect_error)
      begin
        Shifter.new(key)
      rescue => e
        if e.class == ShiftKeyError && expect_error == true
          "Passed"
        else
          "Failed: Key input #{key} raised unexpected error #{e}"
        end
      else
        if expect_error == false
          "Passed"
        else
          "Failed: Key input #{key} did not raise expected error"
        end
      end
    end

    def test_shift(method, key, input, expected_result)
      begin
        result = Shifter.new(key).send(method, input)
      rescue => e
        "Failed: Key #{key}, input #{input}, method #{method} raised unexpected error #{e}"
      else
        if result == expected_result
          "Passed"
        else
          "Failed: Input #{input} with key #{key} returned #{result} instead of #{expected_result}"
        end
      end
    end

    def test_unshift(input)
      result = Unshifter.new.unshift(input)
      result.each do |k, v|
        puts "Shift #{k}: #{v}"
      end
    end
  end
end

puts "-----"
puts "Part 1: Shift"
puts "1: #{Tester.test_key(-1, true)}"
puts "2: #{Tester.test_key(27, true)}"
puts "3: #{ Tester.test_key('asf', true)}"
puts "4: #{ Tester.test_key(nil, true)}"
puts "5: #{ Tester.test_key(0, false)}"
puts "6: #{ Tester.test_key(26, false)}"
puts "7: #{ Tester.test_key(10, false)}"
puts "8: #{ Tester.test_shift(:shift_char, 0, 'A', 'A')}"
puts "9: #{ Tester.test_shift(:shift_char, 0, 'Z', 'Z')}"
puts "10: #{ Tester.test_shift(:shift_char, 26, 'A', 'A')}"
puts "11: #{ Tester.test_shift(:shift_char, 26, 'Z', 'Z')}"
puts "12: #{ Tester.test_shift(:shift_char, 25, 'A', 'Z')}"
puts "13: #{ Tester.test_shift(:shift_char, 25, 'Z', 'Y')}"
puts "14: #{ Tester.test_shift(:shift_char, 1, 'Z', 'A')}"
puts "15: #{ Tester.test_shift(:shift_char, 1, 'A', 'B')}"
puts "16: #{ Tester.test_shift(:shift_char, 1, '1', '1')}"
puts "17: #{ Tester.test_shift(:shift_char, 1, '*', '*')}"
puts "18: #{ Tester.test_shift(:shift_char, 1, '', '')}"
puts "19: #{ Tester.test_shift(:shift, 3, 'HaYLeY iS #1', 'KDBOHB LV #1')}"
puts "20: #{ Tester.test_shift(:shift, 3, '', '')}"
puts "-----"
puts "Part 2: Unshift"
key = 18
input = 'Desperate times call for desperate measures!'
encryption = Shifter.new(key).shift(input)
puts "Key #{key} should be: #{input}"
result = Unshifter.new.unshift(encryption)
result.each do |k, v|
  puts "Shift #{k}: #{v}"
end
puts "-----"


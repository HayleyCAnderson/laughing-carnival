puts("# 1.1")

# Implement an alogirthm to determine if a string has all unique characters.

def all_unique_chars?(str)
  chars = {}
  str.each_char do |char|
    if chars[char]
      return false
    else
      chars[char] = true
    end
  end
  true
end

puts all_unique_chars?("abcdefa") == false
puts all_unique_chars?("bbaa") == false
puts all_unique_chars?("abcdefghi") == true
puts all_unique_chars?("") == true

# What if you  cannot use additional data structures?

def all_unique_chars_slow?(str)
  str.each_char do |char|
    return false if str.count(char) > 1
  end
  true
end

puts all_unique_chars_slow?("abcdefa") == false
puts all_unique_chars_slow?("bbaa") == false
puts all_unique_chars_slow?("abcdefghi") == true
puts all_unique_chars_slow?("") == true

puts("# 1.3")

# Given two strings, write a method to decide if one is a permutation of the other.

def are_permutations?(str_one, str_two)
  return false if str_one.length != str_two.length
  str_one_chars = {}
  str_two_chars = {}
  str_one.each_char do |char|
    if str_one_chars[char]
      str_one_chars[char] += 1
    else
      str_one_chars[char] = 1
    end
  end
  str_two.each_char do |char|
    if str_two_chars[char]
      str_two_chars[char] += 1
    else
      str_two_chars[char] = 1
    end
  end
  str_one_chars == str_two_chars
end

puts are_permutations?("abba", "bbaa") == true
puts are_permutations?("aabb", "bbaa") == true
puts are_permutations?("abc", "aabc") == false
puts are_permutations?("abc", "bcd") == false
puts are_permutations?("", "") == true


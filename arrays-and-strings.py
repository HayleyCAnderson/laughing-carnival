print("# 1.1")

# Implement an algorithm to determine if a string has all unique characters.

def all_unique_chars(string):
    chars = {}
    current_char = len(string) - 1
    all_unique = True
    while current_char >= 0 and all_unique:
        char = string[current_char]
        if char in chars:
            all_unique = False
        else:
            chars[char] = True
        current_char = current_char - 1
    return all_unique

print all_unique_chars("abcdefa") == False
print all_unique_chars("bbaa") == False
print all_unique_chars("abcdefghi") == True
print all_unique_chars("") == True

# What if you  cannot use additional data structures?

def all_unique_chars_slow(string):
    current_char = len(string) - 1
    all_unique = True
    while current_char >= 0 and all_unique:
        char = string[current_char]
        if string.count(char) > 1:
          all_unique = False
        current_char = current_char - 1
    return all_unique

print all_unique_chars_slow("abcdefa") == False
print all_unique_chars_slow("bbaa") == False
print all_unique_chars_slow("abcdefghi") == True
print all_unique_chars_slow("") == True

print("# 1.3")

# Given two strings, write a method to decide if one is a permutation of the other.

def are_permutations(str_one, str_two):
    if len(str_one) != len(str_two):
        return False
    str_one_chars = {}
    str_two_chars = {}
    for char in str_one:
        if char in str_one_chars:
            str_one_chars[char] += 1 #= str_one_chars[char] + 1
        else:
            str_one_chars[char] = 1
    for char in str_two:
        if char in str_two_chars:
            str_two_chars[char] += 1 #= str_two_chars[char] + 1
        else:
            str_two_chars[char] = 1
    return str_one_chars == str_two_chars


print are_permutations("abba", "bbaa") == True
print are_permutations("aabb", "bbaa") == True
print are_permutations("abc", "aabc") == False
print are_permutations("abc", "bcd") == False
print are_permutations("", "") == True


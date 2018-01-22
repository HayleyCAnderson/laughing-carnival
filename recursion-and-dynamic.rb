puts("9.1")

# A child is running up a staircase with n steps, and can hop either 1 step, 2
# steps, or 3 steps at a time. Implement a method to count how many possible
# ways the child can run up the stairs.

def path_count(steps, current=0)
  if current == steps
    1
  elsif current > steps
    0
  else
    path_count(steps, current + 1) +
      path_count(steps, current + 2) +
      path_count(steps, current + 3)
  end
end

puts path_count(0) == 1
puts path_count(1) == 1
puts path_count(2) == 2
puts path_count(3) == 4
puts path_count(4) == 7
puts path_count(5) == 13

def path_count_dynamic(steps, saved={})
  if steps < 0
    0
  elsif steps == 0
    1
  elsif saved[steps]
    saved[steps]
  else
    saved[steps] =
      path_count_dynamic(steps - 1, saved) +
      path_count_dynamic(steps - 2, saved) +
      path_count_dynamic(steps - 3, saved)
    saved[steps]
  end
end

puts path_count_dynamic(0) == 1
puts path_count_dynamic(1) == 1
puts path_count_dynamic(2) == 2
puts path_count_dynamic(3) == 4
puts path_count_dynamic(4) == 7
puts path_count_dynamic(5) == 13

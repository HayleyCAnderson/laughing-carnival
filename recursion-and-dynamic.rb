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

puts("9.2")
# Imagine a robot sitting on the upper left corner of an x by y grid. The robot
# can only move in two direcions: right and down. How many possible paths are
# there for the robot to go from (0, 0) to (x, y)?

def robot_paths(x, y, map={})
  if x == 0 && y == 0
    0
  elsif (x == 0 && y >= 0) || (x >= 0 && y == 0)
    1
  elsif map[x] && map[x][y]
    map[x][y]
  else
    result = robot_paths(x - 1, y, map) + robot_paths(x, y - 1, map)
    map[x] ? map[x][y] = result : map[x] = {y => result}
    map[x][y]
  end
end

puts robot_paths(0, 0) == 0
puts robot_paths(1, 1) == 2
puts robot_paths(2, 2) == 6
puts robot_paths(3, 3) == 20
puts robot_paths(0, 2) == 1
puts robot_paths(3, 1) == 4

# Imagine certain spots are "off limits" such that the robot cannot step on
# them. Design an algorithm to find a path for the robot from the top left to
# the bottom right.

def robot_paths_with_obstacles(x, y, obstacles=[], map={})
  obstacles.each do |obstacle|
    blocked_x = obstacle.first
    blocked_y = obstacle.last
    if map[blocked_x]
      map[blocked_x][blocked_y] = 0
    else
      map[blocked_x] = {blocked_y => 0}
    end
  end

  if (x == 0 && y == 0) || x < 0 || y < 0
    0
  elsif map[x] && map[x][y]
    map[x][y]
  elsif (x == 0 && y == 1) || (x == 1 && y == 0)
    1
  else
    result = robot_paths_with_obstacles(x - 1, y, [], map) +
      robot_paths_with_obstacles(x, y - 1, [], map)
    map[x] ? map[x][y] = result : map[x] = {y => result}
    map[x][y]
  end
end

puts robot_paths_with_obstacles(0, 0) == 0
puts robot_paths_with_obstacles(1, 1, [[0, 1]]) == 1
puts robot_paths_with_obstacles(2, 2, [[0, 2], [1, 1]]) == 1
puts robot_paths_with_obstacles(0, 2, [[0, 1]]) == 0
puts robot_paths_with_obstacles(3, 1, [[1, 1]]) == 2


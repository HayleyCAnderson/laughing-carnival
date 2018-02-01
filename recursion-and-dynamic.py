print("9.1")

# A child is running up a staircase with n steps, and can hop either 1 step, 2
# steps, or 3 steps at a time. Implement a method to count how many possible
# ways the child can run up the stairs.

def path_count(steps, current=0):
    if current == steps:
        return 1
    elif current > steps:
        return 0
    else:
        return path_count(steps, current + 1) + path_count(steps, current + 2) + path_count(steps, current + 3)

print path_count(0) == 1
print path_count(1) == 1
print path_count(2) == 2
print path_count(3) == 4
print path_count(4) == 7
print path_count(5) == 13



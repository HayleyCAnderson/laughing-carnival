class FizzBuzz
  def initialize(end_number)
    @end_number = end_number
  end

  def run
    assert(1)
  end

  def assert(number)
    fizz = number % 3 == 0
    buzz = number % 5 == 0

    print "fizz" if fizz
    print "buzz" if buzz
    print number if !(fizz || buzz)
    print "\n"

    assert(number + 1) if number < @end_number
  end
end

FizzBuzz.new(100).run

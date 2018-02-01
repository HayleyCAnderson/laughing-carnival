class Tracker
  def initialize
    @hosts = {}
  end

  def allocate(host_type)
    if @hosts[host_type]
      number = next_server_number(@hosts[host_type])
      @hosts[host_type] << number
    else
      number = 1
      @hosts[host_type] = [number]
    end
    host_type + number.to_s
  end

  def deallocate(host_name)
    host_type = host_name.gsub(/\d/, "")
    number = host_name.gsub(/\D/, "").to_i
    if @hosts[host_type]
      @hosts[host_type].delete(number)
    end
  end

  private

  def next_server_number(server_numbers)
    sorted_servers = server_numbers.sort
    last_number = 0
    sorted_servers.each do |number|
      if number - last_number > 1
        return last_number + 1
      else
        last_number = number
      end
    end
    last_number + 1
  end
end

tracker = Tracker.new()
puts tracker.allocate("apibox")
puts tracker.allocate("apibox")
tracker.deallocate("apibox1")
puts tracker.allocate("apibox")
puts tracker.allocate("sitebox")

def next_server_number(server_numbers)
  sorted_servers = server_numbers.sort
  last_number = 0
  sorted_servers.each do |number|
    if number - last_number > 1
      return last_number + 1
    else
      last_number = number
    end
  end
  last_number + 1
end

puts "should be 2"
puts next_server_number([5, 3, 1])#== 2
puts "should be 3"
puts next_server_number([5, 4, 1, 2])#== 3
puts "should be 4"
puts next_server_number([3, 2, 1])#== 4
puts "should be 1"
puts next_server_number([2, 3])#== 1
puts "should be 1"
puts next_server_number([])#== 1

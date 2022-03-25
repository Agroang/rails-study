begin
  puts "begin"
  raise NoMethodError
rescue => exception
  puts "rescued #{exception}"
else
  puts "else"
ensure
  puts "ensure"
end

# If there is a rescue the else won't run but the ensure will. With no errors
# everything but the rescue will run.

def method
  puts "method"
rescue
  puts "method rescue"
else
  puts "method else"
ensure
  puts "method ensure"
end

method

# A common way to use ensure is if we are accesing a file or changing a value
# and we want to close that connection or to return the value to its original
# value at the end of the method.

class Time
  class << self # makes zone a Class method/attribute
    attr_accessor :zone
  end

  def self.with_zone(value)
    old_value = self.zone
    self.zone = value
    yield
  ensure
    self.zone = old_value
  end
end

p Time.zone # nil, no value yet
Time.zone = "Tokyo, Japan"
p Time.zone

Time.with_zone "Santiago, Chile" do
  p Time.zone
end

p Time.zone # returns to the original value because of the ensure

# So, ensure it's pretty much very useful for cleanup!

# Methods:

# A duplication problem:
# To avoid duplicative code you can use "dynamic methods" or #method_missing

# Dynamic Methods:

# Code with  lot of duplications.... :
class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end

  def mouse
    info = @data_source.get_mouse_info(@id)
    price = @data_source.get_mouse_price(@id)
    result = "Mouse: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end

  def cpu
    info = @data_source.get_cpu_info(@id)
    price = @data_source.get_cpu_price(@id)
    result = "Cpu: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end

  def keyboard
    info = @data_source.get_keyboard_info(@id)
    price = @data_source.get_keyboard_price(@id)
    result = "Keyboard: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end
# ...
end

# With Dynamic Methods you can call and define methods dynamically and remove
# the duplicated code.

# When you call a method, you usually do so using the standard dot notation:

class MyClass
  def my_method(my_arg)
    my_arg * 2
  end
end

obj = MyClass.new
obj.my_method(3) # => 6

# You also have an alternative: call MyClass#my_method using Object#send in place
# of the dot notation:

obj.send(:my_method, 3) # => 6

# The previous code still calls my_method, but it does so through send. The first
# argument to send is the message that you’re sending to the object—that is, a
# symbol or a string representing the name of a method.
# Any remaining arguments (and the block, if one exists) are simply passed on to
# the method.

# Why would you use send instead of the plain old dot notation? Because with
# send, the name of the method that you want to call becomes just a regular
# argument. You can wait literally until the very last moment to decide which
# method to call, while the code is running. This technique is called "Dynamic
# Dispatch", and you’ll find it wildly useful.

# Example for "Dynamic Dispatch":

method_to_call = :reverse

obj = "abc"
obj.send(method_to_call) # => "cba

# ** Note about symbols vs strings and it's use on methods:
# There are a few different reasons to use symbols in place of regular strings,
# but in the end the choice boils down to conventions. In most cases, symbols are
# used as names of things—in particular, names of metaprogramming-related things
# such as methods. Symbols are a good fit for such names because they are
# immutable: you can change the characters inside a string, but you can’t do that
# for symbols. **

# rather than: 1.send("+", 2)
1.send(:+, 2) # => 3

# Regardless, you can easily convert from string to symbol and back:

"abc".to_sym #=> :abc
:abc.to_s #=> "abc"

# The Object#send method is very powerful—perhaps too powerful. In particular,
# you can call any method with send, including private methods.
# If that kind of breaching of encapsulation makes you uneasy, you can use
# #public_send instead. It’s like send, but it makes a point of respecting the
# receiver’s privacy.

# You’re not limited to calling methods dynamically. You can also define methods
# dynamically!

# You can define a method on the spot with Module#define_method. You just need
# to provide a method name and a block, which becomes the method body:

class MyClass
  define_method :my_method do |my_arg| # Calling Module.define_method
    my_arg * 3
  end
end

obj = MyClass.new
obj.my_method(2) # => 6

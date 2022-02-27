# Methods:

# A duplication problem:
# To avoid duplicative code you can use "dynamic methods" or #method_missing

# Dynamic Methods:

# Code with  lot of duplications.... :

class DS
  def initialize # connect to data source...
  def get_cpu_info(workstation_id) # ...
  def get_cpu_price(workstation_id) # ...
  def get_mouse_info(workstation_id) # ...
  def get_mouse_price(workstation_id) # ...
  def get_keyboard_info(workstation_id) # ...
  def get_keyboard_price(workstation_id) # ...
  def get_display_info(workstation_id) # ...
  def get_display_price(workstation_id) # ...
# ...and so on

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

# There is one important reason to use define_method over the more familiar def
# keyword: define_method allows you to decide the name of the defined method
# at runtime.

# Refactoring the duplicated code:

class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source # using DS.new that holds all the data(info above)
  end

  def mouse
    component :mouse # calling the component method with :mouse, "Dynamic Dispatch"
  end

  def cpu
    component :cpu
  end

  def keyboard
    component :keyboard
  end

  def component(name)
    info = @data_source.send "get_#{name}_info", @id # using #send
    price = @data_source.send "get_#{name}_price", @id
    result = "#{name.capitalize}: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end
end

# A call to mouse is delegated to component, which in turn calls DS#get_mouse_info
# and DS#get_mouse_price. The call also writes the capitalized name of the
# component in the resulting string.
# ** This is really cool, practical and useful! **

my_computer = Computer.new(42, DS.new)
my_computer.cpu # => * Cpu: 2.16 Ghz ($220)

# This new version of Computer is a step forward because it contains far fewer
# duplicated lines—but you still have to write dozens of similar methods. To
# avoid writing all those methods, you can turn to define_method.

# Generating methods dynamically:
# (Going even further and using define_method to make it even shorter)

class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end

  def self.define_component(name)
    define_method(name) do
      info = @data_source.send "get_#{name}_info", @id
      price = @data_source.send "get_#{name}_price", @id
      result = "#{name.capitalize}: #{info} ($#{price})"
      return "* #{result}" if price >= 100
      result
    end
  end

  define_component :mouse # calling the above define_component method
  define_component :cpu
  define_component :keyboard
end

# Note that the three calls to define_component are executed inside the definition
# of Computer, where Computer is the implicit self. Because you’re calling
# define_component on Computer, you have to make it a class method.
# ** Interesting! Understandable after reading it a few times **
# Once again, really cool logic behind this.

# The latest Computer contains minimal duplication, but you can push it even
# further and remove the duplication altogether. How? By getting rid of all those
# calls to define_component. You can do that by introspecting the data_source
# argument and extracting the names of all components:

class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
    data_source.methods.grep(/^get_(.*)_info$/) { Computer.define_component $1 }
  end

  def self.define_component(name)
    define_method(name) do
      # ...
    end
  end
end

# The new line in initialize is where the magic happens.
# First, if you pass a block to Array#grep, the block is evaluated for each
# element that matches the regular expression. Second, the string matching the
# parenthesized part of the regular expression is stored in the global variable
# $1. So, if data_source has methods named get_cpu_info and get_mouse_info, this
# code ultimately calls Computer.define_component twice, with the strings "cpu"
# and "mouse". Note that define_method works equally well with a string or a symbol.

# The duplicated code is finally gone for good. As a bonus, you don’t even have
# to write or maintain the list of components. If someone adds a new component
# to DS, the Computer class will support it automatically. Isn’t that wonderful?

# As far as I understand, the above is just to create the methods (the grep)
# stuff, you still use info and price on the actual method define_component,
# but this makes the call to define_component with the name that you get from
# the grep.

# For the second possible solution, you need to know about some strange methods
# that are not really methods and a very special method named method_missing.

# method_missing:

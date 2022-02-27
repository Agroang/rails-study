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

# With Ruby, there’s no compiler to enforce method calls. This means you can
# call a method that doesn’t exist. For example:

class Lawyer; end
nick = Lawyer.new
nick.talk_simple

# NoMethodError: undefined method `talk_simple' for #<Lawyer:0x007f801aa81938>

# When you call talk_simple, Ruby goes into nick’s class and browses its instance
# methods. If it can’t find talk_simple there, it searches up the ancestors chain
# into Object and eventually into BasicObject.

# Because Ruby can’t find talk_simple anywhere, it admits defeat by calling a
# method named method_missing on nick, the original receiver. Ruby knows that
# method_missing is there, because it’s a private instance method of BasicObject
# that every object inherits.

# You can experiment by calling method_missing yourself. It’s a private method,
# but you can get to it through send:

nick.send :method_missing, :my_method

# NoMethodError: undefined method `my_method' for #<Lawyer:0x007f801b0f4978>

# You have just done exactly what Ruby does. You told the object, “I tried to
# call a method named my_method on you, and you did not understand.”
# BasicObject#method_missing responded by raising a NoMethodError. In fact, this
# is what method_missing does for a living. It’s like an object’s dead-letter
# office, the place where unknown messages eventually end up (and the place where
# NoMethodErrors come from).

# Overriding method_missing:

# You can override it to intercept unknown messages. Each message landing on
# method_missing’s desk includes the name of the method that was called, plus
# any arguments and blocks associated with the call.

class Lawyer
  def method_missing(method, *args)
    puts "You called: #{method}(#{args.join(', ')})"
    puts "(You also passed it a block)" if block_given?
  end
end

bob = Lawyer.new
bob.talk_simple('a', 'b') do
  # a block
end

# You called: talk_simple(a, b)
# (You also passed it a block)

# Ghost Methods:

# When you need to define many similar methods, you can spare yourself the
# definitions and just respond to calls through method_missing. This is like saying
# to the object, “If they ask you something and you don’t understand, do this.”
# From the caller’s side, a message that’s processed by method_missing looks like
# a regular call—but on the receiver’s side, it has no corresponding method.
# This trick is called a Ghost Method.

# Examples:

class C
  def method_missing(name, *args)
    name.to_s.reverse
  end
end

obj = C.new
obj.my_ghost_method # => "dohtem_tsohg_ym"

# Dynamic Proxies:

# Ghost Methods are usually icing on the cake, but some objects actually
# rely almost exclusively on them. These objects are often wrappers for something
# else—maybe another object, a web service, or code written in a different
# language. They collect method calls through method_missing and forward them
# to the wrapped object.

# An object which catches Ghost Methods and forwards them to another object, is
# called a Dynamic Proxy.

# Example:

class MyDynamicProxy
  def initialize(target)
    @target = target
  end

  def method_missing(name, *args, &block) # &block is it accept a ruby block
    "result: #{@target.send(name, *args, &block)}"
  end
end

obj = MyDynamicProxy.new("a string")
obj.reverse # => "result: gnirts a"

# Another example:

class Foo
  def method_missing(sym, *args, &block)
     puts "#{sym} was called with #{args} and returned #{block.call(args)}"
  end
end

bar = Foo.new
bar.test(1,2,3) do |a|
  a.map{|e| e + 2}
end

# => test was called with [1, 2, 3] and returned [3, 4, 5]

# ** This is some quite interesting and mindblowing stuff right here **

# Refactoring again, now with missing_method:

# old unrefactored version:
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

class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end

  def method_missing(name)
    super if !@data_source.respond_to?("get_#{name}_info")
    info = @data_source.send("get_#{name}_info", @id)
    price = @data_source.send("get_#{name}_price", @id)
    result = "#{name.capitalize}: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end
end

my_computer = Computer.new(42, DS.new)
my_computer.cpu # => * Cpu: 2.9 Ghz quad-core ($120)

# What happens when you call a method such as Computer#mouse? The call gets
# routed to method_missing, which checks whether the wrapped data source has
# a get_mouse_info method. If it doesn’t have one, the call falls back to
# BasicObject#method_missing, which throws a NoMethodError. If the data source
# knows about the component, the original call is converted into two calls to
# DS#get_mouse_info and DS#get_mouse_price. The values returned from these calls
# are used to build the final result.

# ** This is a little bit hard to grasp..particularly with super in there as
# well **

# respond_to_missing? :

# If you specifically ask a Computer whether it responds to a Ghost Method, it
# will flat-out lie:

cmp = Computer.new(0, DS.new)
cmp.respond_to?(:mouse) # => false

# This behavior can be problematic, because respond_to? is a commonly used
# method. (If you need convincing, just note that the Computer itself is calling
# respond_to? on the data source.) Fortunately, Ruby provides a clean mechanism
# to make respond_to? aware of Ghost Methods.

# respond_to? calls a method named respond_to_missing? that is supposed to return
# true if a method is a Ghost Method. (In your mind, you could rename
# respond_to_missing? to something like ghost_method?.) To prevent respond_to?
# from lying, override respond_to_missing? every time you override method_missing:

class Computer
# ...
  def respond_to_missing?(method, include_private = false)
    @data_source.respond_to?("get_#{method}_info") || super
  end
end

# The code in this respond_to_missing? is similar to the first line of
# method_missing: it finds out whether a method is a Ghost Method. If it is, it
# returns true. If it isn’t, it calls super. In this case, super is the default
# Object#respond_to_missing?, which always returns false.
# Now respond_to? will learn about your Ghost Methods from respond_to_missing?
# and return the right result:

cmp.respond_to?(:mouse) # => true

# The rule is now this: remember to override respond_to_missing? every time you
# override method_missing.

# const_missing:

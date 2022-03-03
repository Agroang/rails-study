# Blocks:

# Blocks are very useful for controlling scope, which is very powerful in
# metaprogramming. Blocks are just one member of a larger family of “callable
# objects,” which include objects such as procs and lambdas. Blocks come from
# functional programming rather than object oriented programming.

# The Basics of Blocks:

def a_method(a, b)
a + yield(a, b)
end
a_method(1, 2) {|x, y| (x + y) * 3 } # => 10

# You can define a block with either curly braces or the do…end keywords. A
# common convention is to use curly braces for single-line blocks and do…end
# for multiline blocks.

# You can define a block only when you call a method. The block is passed
# straight into the method, and the method can call back to the block with the
# yield keyword.

# Optionally, a block can have arguments, like x and y in the previous example.
# When you yield to the block, you can provide values for its arguments, just
# like you do when you call a method. Also, like a method, a block returns the
# result of the last line of code it evaluates.

# Within a method, you can ask Ruby whether the current call includes a block.
# You can do that with the Kernel#block_given? method:

def a_method
  return yield if block_given?
  'no block'
end

a_method # => "no block"
a_method { "here's a block!" } # => "here's a block!"

# If you use yield when block_given? is false, you’ll get a runtime error.

# (About exemptions... :)

# Exceptions are rescued in a begin/end block:

begin
  # code that might raise
rescue
  # handle exception
end

# You may rescue different types of exceptions in different ways:

begin
  # ...
rescue ArgumentError
  # handle ArgumentError
rescue NameError
  # handle NameError
rescue
  # handle any StandardError
end

# By default, StandardError and its subclasses are rescued. You can rescue a
# specific set of exception classes (and their subclasses) by listing them after
# rescue:

begin
  # ...
rescue ArgumentError, NameError
  # handle ArgumentError or NameError
end

# To always run some code whether an exception was raised or not, use ensure:

begin
  # ...
rescue
  # ...
ensure
  # this always runs
end

# Blocks Are Closures:

# A block is not just a floating piece of code. You can’t run code in a vacuum.
# When code runs, it needs an environment: local variables, instance variables,
# self….

# Because these entities are basically names bound to objects, you can call
# them the bindings for short. The main point about blocks is that they are all
# inclusive and come ready to run. They contain both the code and a set of
# bindings.

# When you define the block, it simply grabs the bindings that are there at that
# moment, and then it carries those bindings along when you pass the block into a
# method:

def my_method
  x = "Goodbye"
  yield("cruel")
end

x = "Hello"
my_method {|y| "#{x}, #{y} world" } # => "Hello, cruel world"
# Picking x from outer scope, and "y" is picked when yield is called with that
# argument.

# When you create the block, you capture the local bindings, such as x. Then
# you pass the block to a method that has its own separate set of bindings. In
# the previous example, those bindings also include a variable named x. Still,
# the code in the block sees the x that was around when the block was defined,
# not the method’s x, which is not visible at all in the block.

# You can also define additional bindings inside the block, but they disappear
# after the block ends:

def just_yield
  yield
end

top_level_variable = 1

just_yield do # this is the method above and yields to the block
  top_level_variable += 1
  local_to_block = 1
end

top_level_variable # => 2
local_to_block # => Error!

# Because of the properties above, a computer scientist would say that a block
# is a closure. For the rest of us, this means a block captures the local bindings
# and carries them along with it.

# So, how do you use closures in practice? To understand that, take a closer
# look at the place where all the bindings reside—the scope.

# The Scope:

# This example shows how scope changes as your program runs, tracking the
# names of bindings with the Kernel#local_variables method:
# The Scope changes as you run the program!

v1 = 1
class MyClass
  v2 = 2
  local_variables # => [:v2]
  def my_method
    v3 = 3
    local_variables
  end
  local_variables # => [:v2]
end

obj = MyClass.new
obj.my_method # => [:v3]
obj.my_method # => [:v3]
local_variables # => [:v1, :obj]

# Some languages, such as Java and C#, allow “inner scopes” to see variables
# from “outer scopes.” That kind of nested visibility doesn’t happen in Ruby,
# where scopes are sharply separated: as soon as you enter a new scope, the
# previous bindings are replaced by a new set of bindings.

# Question: I thought I was able to see the values of outer variables from inner
# but not viceversa...need to check in details what does the above means.
# local variables

# Global Variables and Top-Level Instance Variables:

# Global variables can be accessed by any scope:

def a_scope
  $var = "some value"
end

def another_scope
  $var
end

a_scope
another_scope # => "some value

# The problem with global variables is that every part of the system can change
# them, so in no time you’ll find it difficult to track who is changing what.
# For this reason, the general rule is this: when it comes to global variables,
# use them sparingly, if ever.

# You can sometimes use a top-level instance variable in place of a global
# variable. These are the instance variables of the top-level main object.

@var = "The top-level @var"

def my_method
  @var
end

my_method # => "The top-level @var"

# You can access a top-level instance variable whenever main takes the role of self, as
# in the previous example. When any other object is self, the top-level instance variable
# is out of scope.

class MyClass
  def my_method
    @var = "This is not the top-level @var!"
  end
end

# Being less universally accessible, top-level instance variables are generally
# considered safer than global variables—but not by a wide margin.

# “Whenever the program changes scope, some bindings are replaced by a new set of
# bindings”.  In particular, local variables change at every new scope. (That’s
# why they’re “local.”)

# Scope Gates:

# There are exactly three places where a program leaves the previous scope
# behind and opens a new one:

# • Class definitions
# • Module definitions
# • Methods

# Scope changes whenever the program enters (or exits) a class or module
# definition or a method. These three borders are marked by the keywords class,
# module, and def, respectively. Each of these keywords acts like a Scope Gate.

a = 1
defined? a # => "local-variable"

module MyModule
  b = 1
  defined? a # => nil
  defined? b # => "local-variable"
end

defined? a # => "local-variable"
defined? b # => nil

# Question: Similar to the last one, I thought I had access to outer variables
# need to confirm ...

# Another example but now clearly stating the scope gates:

v1 = 1

class MyClass # SCOPE GATE: entering class
  v2 = 2
  local_variables # => ["v2"]
  def my_method # SCOPE GATE: entering def
    v3 = 3
    local_variables
  end # SCOPE GATE: leaving def
  local_variables # => ["v2"]
end # SCOPE GATE: leaving class

obj = MyClass.new
obj.my_method # => [:v3]
local_variables # => [:v1, :obj]

# There is a subtle difference between class and module on one side and def on
# the other. The code in a class or module definition is executed immediately.
# Conversely, the code in a method definition is executed later, when you
# eventually call the method. However, as you write your program, you usually
# don’t care when it changes scope—you only care that it does.

# Flattening the Scope:

# The more you become proficient in Ruby, the more you get into difficult
# situations where you want to pass bindings through a Scope Gate.

my_var = "Success"

class MyClass
  # We want to print my_var here...
  def my_method
    # ..and here
  end
end

# Look at the class Scope Gate first. You can’t pass my_var through it, but you
# can replace class with something else that is not a Scope Gate: a method call.
# If you could call a method instead of using the class keyword, you could capture
# my_var in a closure and pass that closure to the method.

# If you look at Ruby’s documentation, you’ll find the answer: Class.new is a
# perfect replacement for class. You can also define instance methods in the
# class if you pass a block to Class.new:

my_var = "Success"

MyClass = Class.new do
  # Now we can print my_var here...
  puts "#{my_var} in the class definition!"
  def my_method
    # ...but how can we print it here?
  end
end

# Now, how can you pass my_var through the def Scope Gate? Once again, you
# have to replace the keyword with a method call. Think of the discussion about
# Dynamic Methods: instead of def, you can use Module#define_method:

my_var = "Success"

MyClass = Class.new do
  puts "#{my_var} in the class definition"
  define_method :my_method do
    puts "#{my_var} in the method"
  end
end

MyClass.new.my_method

# => Success in the class definition
# => Success in the method

# If you replace Scope Gates with method calls, you allow one scope to see
# variables from another scope. Technically, this trick should be called nested
# lexical scopes, but many Ruby coders refer to it simply as “flattening the
# scope,” meaning that the two scopes share variables as if the scopes were
# squeezed together. For short, you can call this Flat Scope.

# Another example with Flat Scope:

# Use a closure to share variables between two scopes:

class C
  def an_attribute
    @attr
  end
end

obj = C.new
a_variable = 100

# flat scope:

obj.instance_eval do
  @attr = a_variable
end

obj.an_attribute # => 100

# Question: How do you use #instance_eval? Need more information about this.
# takes a block and instead of executing in the current context it does it in
# another context. There is also class_eval

# Sharing the scope:

# Once you know about Flat Scopes, you can do pretty much whatever you
# want with scopes. For example, maybe you want to share a variable among
# a few methods, and you don’t want anybody else to see that variable. You can
# do that by defining all the methods in the same Flat Scope as the variable:

def define_methods
  shared = 0
  Kernel.send :define_method, :counter do
    shared
  end

  Kernel.send :define_method, :inc do |x|
    shared += x
  end
end

define_methods
counter # => 0
inc(4)
counter # => 4

# ** Quite interesting way ...not sure if I completely understand it's usability
# but quite impressive nevertheless **

# This example defines two Kernel Methods. (It also uses Dynamic Dispatch to
# access the private class method define_method on Kernel.) Both Kernel#counter
# and Kernel#inc can see the shared variable. No other method can see shared,
# because it’s protected by a Scope Gate —that’s what the define_methods
# method is for. This smart way to control the sharing of variables is called a
# Shared Scope.

# Shared Scopes are not used much in practice, but they’re a powerful trick
# and a good example of the power of scopes. With a combination of Scope
# Gates, Flat Scopes, and Shared Scopes, you can twist and bend your scopes
# to see exactly the variables you need, from the place you want.

# Another example using Shared Scope:

lambda {
  shared = 10
  self.class.class_eval do
    define_method :counter do
      shared
    end

    define_method :down do
      shared -= 1
    end
  end
}.call

counter # => 10
3.times { down }
counter # => 7

# Closures Wrap-Up:

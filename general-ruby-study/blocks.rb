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

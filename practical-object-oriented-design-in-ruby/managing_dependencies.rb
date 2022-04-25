# For any desired behavior, an object either knows it personally, inherits it,
# or knows another object who knows it.

# Because well-designed objects have a single responsibility, their very nature
# requires that they collaborate to accomplish complex tasks.

# To collaborate, an object must know something know about others. Knowing
# creates a dependency. If not managed carefully, these dependencies will
# strangle your application.

# An object depends on another object if, when one object changes, the other
# might be forced to change in turn.

# An object has a dependency when it knows:
# - The name of another class
# - The name of a message that it intends to send to someone other than self
# - The arguments that a message requires
# - The order of those arguments

# Your design challenge is to manage dependencies so that each class has the
# fewest possible; a class should know just enough to do its job and not one
# thing more

# Coupling Between Objects (CBO): The more a model knows about another, the more
# coupled they are. The more coupled they are, the more they behave like a
# single entity.

# When two (or three or more) objects are so tightly coupled that they behave as
# a unit, it’s impossible to reuse just one. Changes to one object force changes
# to all. Left unchecked, unmanaged dependencies cause an entire application to
# become an entangled mess. A day will come when it’s easier to rewrite
# everything than to change anything.

# Decoupling classes is a very good idea and dependecy injection is a technique
# to do that, by passing an object directly on the initialization instead of
# creating it inside the class itself (and creating that dependency to an
# specific model).

# Dependencies are foreign invaders that represent vulnerabilities, and they
# should be concise, explicit, and isolated.

# You can also try to separate the messages (methods) that depend on certain
# models. Remember to keep classes as simple as possible and handling only one
# thing.

def gear_inches
  #... a few lines of scary math
  foo = some_intermediate_result * wheel.diameter
  #... more lines of scary math
end

# The above method can be simplified (and reduce dependency from gear_inches) by
# changing it into:

def gear_inches
  #... a few lines of scary math
  foo = some_intermediate_result * diameter
  #... more lines of scary math
end

def diameter
  wheel.diameter
end

# Another dependency issue relates to the order of the arguments, if you pass
# it in the wrong order you will get the wrong results (and you may not even
# noticed it). To avoid this kind of problems the best idea is to use "Keyword
# Arguments."

class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring:, cog:, wheel:) # Adding ":" at the end
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end
  # ...
end

# Now when you create a new instance of Gear you will pass explicitly the
# arguments that it require, and using the keywords, that way there will no
# order dependency.

puts Gear.new(
  wheel: Wheel.new(26, 1.5),
  chainring: 52,
  cog: 11).gear_inches
# => 137.0909090909091

# Keyword arguments offer several advantages...

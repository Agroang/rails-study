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

# Keyword arguments may be passed in any order. This technique adds verbosity.
# In many situations verbosity is a detriment, but in this case, it has value.
# The verbosity exists at the intersection between the needs of the present and
# the uncertainty of the future.

# Using keyword arguments requires the sender and the receiver of a message to
# state the keyword names. This results in explicit documentation at both ends
# of the message. Future maintainers will be grateful for this information.
# You can also set defaults right in the argument list, just like positional
# arguments.

# Example setting default values for cog and chainring:

class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring: 40, cog: 18, wheel:)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end
end

puts Gear.new(wheel: Wheel.new(26, 1.5)).chainring
# => 40

# You can also use as a default a message (method):

def initialize(chainring: default_chainring, cog: 18, wheel:)
  # ..
end

def default_chainring
  # value or math
end

# It’s best to embed simple defaults right in the parameter list, but if getting
# the default requires running a bit of code, don’t hesitate to send a message.

# If you don't have control over the code because it's external to your app,
# use a wrapping method to isolate external dependencies.

# When Gear is part of an external interface
module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel
    def initialize(chainring, cog, wheel)
      @chainring = chainring
      @cog = cog
      @wheel = wheel
    end
    # ...
  end
end

# wrap the interface to protect yourself from changes
module GearWrapper
  def self.gear(chainring:, cog:, wheel:)
    SomeFramework::Gear.new(chainring, cog, wheel)
  end
end

# Now you can create a new Gear using keyword arguments
puts GearWrapper.gear(
  chainring: 52,
  cog: 11,
  wheel: Wheel.new(26, 1.5)).gear_inches
# => 137.0909090909091

# In the example above, although GearWrapper is a module, is not meant to be
# included in another class, it’s meant to directly respond to the gear message.
# An object whose purpose is to create other objects is a factory; the word
# factory implies nothing more, and use of it is the most expedient way to
# communicate this idea.

# The above technique for replacing positional arguments with keywords is
# perfect for cases where you are forced to depend on external interfaces that
# you cannot change. Do not allow these kinds of external dependencies to
# permeate your code; protect yourself by wrapping each in a method that is
# owned by your own application.

# The choices you make about the direction of dependencies have far-reaching
# consequences that manifest themselves for the life of your application. If you
# get this right, your application will be pleasant to work on and easy to
# maintain. If you get it wrong, then the dependencies will gradually take
# over and the application will become harder and harder to change.

# There are three simple truths about code:
# • Some classes are more likely than others to have changes in requirements.
# • Concrete classes are more likely to change than abstract classes.
# • Changing a class that has many dependents will result in widespread
# consequences.

# Ruby base classes always change less often than your own classes, and you can
# continue to depend on them without another thought.

# Framework classes that you use could also change depending of the stage of
# development.

# From the point of view of classes: Depend on things that change less often
# than you do. Worst case scenario is having a class that has many dependents
# and that is very likely to change.

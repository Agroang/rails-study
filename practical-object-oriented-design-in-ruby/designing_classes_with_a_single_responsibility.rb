# The foundation of an object-oriented system is the message, but the most
# visible organizational structure is the class.

# Your application needs to work right now just once; it must be easy to change
# forever. This quality of easy changeability reveals the craft of programming.
# Achieving it takes knowledge, skill, and a bit of artistic creativity.

# Design is more the art of preserving changeability than it is the act of
# achieving perfection.

# Code should be:

# Transparent: The consequences of change should be obvious in the code that is
# changing and in distant code that relies upon it.

# Reasonable: The cost of any change should be proportional to the benefits the
# change achieves.

# Usable: Existing code should be usable in new and unexpected contexts.

# Exemplary: The code itself should encourage those who change it to perpetuate
# these qualities.

# Code that is Transparent, Reasonable, Usable, and Exemplary (TRUE) not only
# meets today’s needs but can also be changed to meet the needs of the future.
# The first step in creating code that is TRUE is to ensure that each class has
# a single, well defined responsibility.

# A class should do the smallest possible useful thing; that is, it should have a
# single responsibility.

# Applications that are easy to change consist of classes that are easy to
# reuse. Reusable classes are pluggable units of well-defined behavior that have
# few entanglements. An application that is easy to change is like a box of
# building blocks; you can select just the pieces you need and assemble them in
# unanticipated ways.

# You increase your application’s chance of breaking unexpectedly if you depend
# on classes that do too much.

# Remember that a class should do the smallest possible useful thing. That thing
# ought to be simple to describe. If the simplest description you can devise
# uses the word “and,” the class likely has more than one responsibility. If it
# uses the word “or,” then the class has more than one responsibility and they
# aren’t even very related.

# The Single Responsibility Principle (SRP) has its roots in Rebecca Wirfs-Brock
# and Brian Wilkerson’s idea of Responsibility-Driven Design (RDD). They say, “A
# class has responsibilities that fulfill its purpose.” SRP doesn’t require that
# a class do only one very narrow thing or that it change for only a single
# nitpicky reason; instead SRP requires that a class be cohesive—that everything
# the class does be highly related to its purpose.

# The future is uncertain and you will never know less than you know right now.

# When to make design decision changes: Make the decision only when you must
# with the information you have at that time.

# Because change is inevitable, coding in a changeable style has big future
# payoffs.

# When you create classes that have a single responsibility, every tiny bit of
# behavior lives in one and only one place. The phrase “Don’t Repeat Yourself”
# (DRY) is a shortcut for this idea. DRY code tolerates change because any
# change in behavior can be made by changing code in just one place.

# Always wrap instance variables in accessor methods instead of directly
# referring to  variables. That is, do not write code like this ratio method:

class Gear
  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def ratio
    @chainring / @cog.to_f # <-- road to ruin
  end
end

# Hide the variables, even from the class that defines them, by wrapping them in
# methods. Ruby provides attr_reader as an easy way to create the encapsulating
# methods:

class Gear
  attr_reader :chainring, :cog # <-------

  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def ratio
    chainring / cog.to_f # <-------
  end
end

# Using attr_reader caused Ruby to create simple wrapper methods for the
# variables. Here’s a virtual representation of the one it created for cog:

# default-ish implementation via attr_reader:
def cog
  @cog
end

# This cog method is now the only place in the code that understands what cog
# means. Cog becomes the result of a message send. Implementing this method
# changes cog from data (which is referenced all over) to behavior (which is
# defined once).
# * Above is important and really nice, once you understand. I want this kind
# of code *

# attr_reader creates public methods, so if you prefer the method to be private
# then you can specify that as well:

class Gear
  private
  attr_reader :chainring, :cog # <-------

  public
  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def ratio
    chainring / cog.to_f # <-------
  end
end

# You should hide data from yourself. Doing so protects the code from being
# affected by unexpected changes.

# Send messages to access variables, even if you think of them as data.

# Direct references into complicated structures are confusing, because they
# obscure what the data really is, and they are a maintenance nightmare, because
# every reference will need to be changed when the structure of the array
# changes.

# Example that can create problems due to the data structure:

class ObscuringReferences
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def diameters
    # 0 is rim, 1 is tire
    data.collect {|cell|
    cell[0] + (cell[1] * 2)}
  end
  # ... many other methods that index into the array
end
# => The above example depends on having the right data inside the array at
# index 0 and 1

# In Ruby it’s easy to separate structure from meaning. Just as you can use a
# method to wrap an instance variable, you can use the Ruby Struct class to wrap
# a structure. In the following example, RevealingReferences has the same
# interface as the previous class. It takes a two-dimensional array as an
# initialization argument, and it implements the diameters method. Despite these
# external similarities, its internal implementation is very different.

class RevealingReferences
  attr_reader :wheels

  def initialize(data)
  @wheels = wheelify(data)
  end

  def diameters
    wheels.collect {|wheel|
    wheel.rim + (wheel.tire * 2)}
  end

  # now everyone can send rim/tire to wheel
  Wheel = Struct.new(:rim, :tire)

  def wheelify(data)
    data.collect {|cell|
    Wheel.new(cell[0], cell[1])}
  end
end

# The diameters method above now has no knowledge of the internal structure
# of the array. All diameters knows is that the message wheels returns an
# enumerable and that each enumerated thing responds to rim and tire. What were
# once references to cell[1] have been transformed into message sends to
# wheel.tire. All knowledge of the structure of the incoming array has been
# isolated inside the wheelify method, which converts the array of Arrays into
# an array of Structs.

# The wheelify method contains the only bit of code that understands the
# structure of the incoming array. If the input changes, the code will change in
# just this one place. It takes four new lines of code to create the Wheel
# Struct and to define the wheelify method, but these few lines of code are a
# minor inconvenience compared to the permanent cost of repeatedly indexing into
# a complex array.

# This style of code allows you to protect against changes in externally owned
# data structures and to make your code more readable and intention revealing.
# It trades indexing into a structure for sending messages to an object.

# Methods, like classes, should have a single responsibility. All of the same
# reasons apply; having just one responsibility makes them easy to change and
# easy to reuse.

def diameters
  wheels.collect {|wheel|
    wheel.rim + (wheel.tire * 2)}
end

# We have simplify the above method to only do one thing, and make another
# method that will be in charge of the actual calculation:

# first - iterate over the array
def diameters
  wheels.collect {|wheel| diameter(wheel)}
end

# second - calculate diameter of ONE wheel
def diameter(wheel)
 wheel.rim + (wheel.tire * 2)
end

# Same with the above method (original first, then the extraction version):

def gear_inches
  # tire goes around rim twice for diameter
  ratio * (rim + (tire * 2))
end

# New version
def gear_inches
  ratio * diameter
end

def diameter
  rim + (tire * 2)
end

# Refactoring can bring to light a lot of stuff. You should do it needed, not
# because the design is clear, but because it isn’t. Good practices reveal
# design.

# This isolation allows change without consequence and reuse without duplication.

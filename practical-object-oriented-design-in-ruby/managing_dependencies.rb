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

# The distinction between a message that asks for what the sender wants and a
# message that tells the receiver how to behave may seem subtle, but the
# consequences are significant.

# Knowning too much exposes a lot of the methods of a class, so we want to
# expose less so the classes do not depend on those methods, allowing changes
# if needed without having to change multiple classes to achieve that.

# The things that a class knows about other objects make up its context.
# The context that an object expects has a direct effect on how difficult it is
# to reuse. Objects that have a simple context are easy to use and easy to test;
# they expect few things from their surroundings. Objects that have a complicated
# context are hard to use and hard to test; they require complicated setup before
# they can do anything. The best possible situation is for an object to be
# completely independent of its context. An object that could collaborate with
# others without knowing who they are or what they do could be reused in novel
# and unanticipated ways.

# Blind trust is a keystone of object-oriented design. It allows objects to
# collaborate without binding themselves to context and is necessary in any
# application that expects to grow and change.

# "What" over "how" (the object knows "what" it wants but doesn't need to know
# "how" the other object does it)

# Switching your attention from objects to messages allows you to concentrate on
# designing an application built upon public interfaces.

# Think about interfaces. Create them intentionally. It is your interfaces, more
# than all of your tests and any of your code, that define your application and
# determine its future.

# Every time you create a class, declare its interfaces. Methods in the public
# interface should:

# • Be explicitly identified as such.
# • Be more about what than how.
# • Have names that, insofar as you can anticipate, will not change.
# • Prefer keyword arguments.

# Be just as intentional about the private interface; make it inescapably
# obvious. Tests, because they serve as documentation, can support this endeavor.
# Either do not test private methods or, if you must, segregate those tests from
# the tests of public methods.

# Ruby provides three relevant keywords: public, protected, and private. Use
# of these keywords serves two distinct purposes. First, they indicate which
# methods are stable and which are unstable. Second, they control how visible a
# method is to other parts of your application. These two purposes are very
# different. Conveying information that a method is stable or unstable is one
# thing; attempting to control how others use it is quite another.

# The private keyword denotes the least stable kind of method and provides the
# most restricted visibility.

# The protected keyword also indicates an unstable method, but one with slightly
# different visibility restrictions. Protected methods allow explicit receivers
# as long as the receiver is self or an instance of the same class or subclass
# of self.

# The public keyword indicates that a method is stable; public methods are
# visible everywhere.

# Users of a class can redefine any method to public regardless of its initial
# declaration. The private and protected keywords are more like flexible
# barriers than concrete restrictions. Anyone can get by them; it’s simply a
# matter of expending the effort.

# A dependency on a private method of an external framework is a form of
# technical debt. Avoid these dependencies.

# Create public methods that allow senders to get what they want without knowing
# how your class implements its behavior.

# The Law of Demeter is a set of coding rules that results in loosely coupled
# objects. Loose coupling is nearly always a virtue but is just one component of
# design and must be balanced against competing needs.

# Demeter restricts the set of objects to which a method may send messages; it
# prohibits routing a message to a third object via a second object of a
# different type. Demeter is often paraphrased as “only talk to your immediate
# neighbors” or “use only one dot.”
# * This one seems a little bit hard to impose...we usually route! *

# Demeter became a “law” because a human being decided so; don’t be fooled by
# its grandiose name. As a law, it’s more like “floss your teeth every day” than
# it is like gravity.

# Certain “violations” of Demeter reduce your application’s flexibility and
# maintainability, while others make perfect sense.

# One common way to remove train wrecks (object.object.object.etc...) from code
# is to use delegation to avoid the dots. In object-oriented terms, to delegate
# a message is to pass it on to another object, often via a wrapper method. The
# wrapper method encapsulates, or hides, knowledge that would otherwise be
# embodied in the message chain.

# There are a number of ways to accomplish delegation. Ruby provides support via
# delegate.rb and forwardable.rb, which make it easy for an object to
# automatically intercept a message sent to self and to instead send it
# somewhere else.

# Delegation is tempting as a solution to the Demeter problem because it removes
# the visible evidence of violations. This technique is sometimes useful, but
# beware: It can result in code that obeys the letter of the law while ignoring
# its spirit. Using delegation to hide tight coupling is not the same as
# decoupling the code.

# Message chains like customer.bicycle.wheel.rotate occur when your
# design thoughts are unduly influenced by objects you already know. Your
# familiarity with the public interfaces of known objects may lead you to string
# together long message chains to get at distant behavior (because you know the
# behavior and you know how to get it)

# A change in the chain can break everything and even worse, it binds the object
# to a very specific implementation thus in cannot be used in any other context.

# The train wrecks of Demeter violations are clues that there are objects whose
# public interfaces are lacking.

# Focusing on messages reveals objects that might otherwise be overlooked.
# When messages are trusting and ask for what the sender wants instead of
# telling the receiver how to behave, objects naturally evolve public interfaces
# that are flexible and reusable in novel and unexpected ways.

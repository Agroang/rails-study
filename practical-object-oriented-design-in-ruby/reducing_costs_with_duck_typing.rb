# Programming languages use the term type to describe the category of the
# contents of a variable. Procedural languages provide a small, fixed number of
# types, generally used to describe kinds of data. Even the humblest language
# defines types to hold strings, numbers, and arrays.

# It is knowledge of the category of the contents of a variable, or its type,
# that allows an application to have an expectation about how those contents will
# behave.

# In Ruby, these expectations about the behavior of an object come in the form
# of beliefs about its public interface.

# However, you are not limited to expecting an object to respond to just one
# interface. A Ruby object is like a partygoer at a masquerade ball that changes
# masks to suit the theme. It can expose a different face to every viewer; it can
# implement many different interfaces.

# Users of an object need not, and should not, be concerned about its class.
# Class is just one way for an object to acquire a public interface; the public
# interface an object obtains by way of its class may be one of several that it
# contains. Applications may define many public interfaces that are not related
# to one specific class; these interfaces cut across class. Users of any object
# can blithely expect it to act like any, or all, of the public interfaces it
# implements. It’s not what an object is that matters, it’s what it does.

#  Sequence diagrams should always be simpler than the code they represent; when
# they are not, something is wrong with the design.

# The idea is to think in an abstract way, if needed add the expected "message"
# (method) into all the possible classes that might be passed as argument and
# to use a general argument that will be one of those classes, that will know
# how to respond to that general method:

# Trip preparation becomes easier
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each {|preparer|
    preparer.prepare_trip(self)}
  end
  # ...
end

# when every preparer is a Duck
# that responds to 'prepare_trip'
class Mechanic
  def prepare_trip(trip)
    trip.bicycles.each {|bicycle|
    prepare_bicycle(bicycle)}
  end
  # ...
end

class TripCoordinator
  def prepare_trip(trip)
    buy_food(trip.customers)
  end
  # ...
end

class Driver
  def prepare_trip(trip)
    vehicle = trip.vehicle
    gas_up(vehicle)
    fill_water_tank(vehicle)
  end
  # ...
end

# There is a risk of using duck type, it easy to extend but hard to understand.
# The same applies for using concrete classes, its verbose and easy to
# understand but hard to extend.

# This tension between the costs of concretion and the costs of abstraction is
# fundamental to object-oriented design. Concrete code is easy to understand but
# costly to extend. Abstract code may initially seem more obscure but, once
# understood, is far easier to change.

# Polymorphism in OOP refers to the ability of many different objects to
# respond to the same message. Senders of the message need not care about the
# class of the receiver; receivers supply their own specific version of the
# behavior. There are a number of ways to achieve polymorphism; duck typing, as
# you have surely guessed, is one. Inheritance and behavior sharing (via Ruby
# modules) are others.

# When you use polymorphism, it’s up to you to make sure all of your objects are
# well-behaved.

# In our example above, the prepare_trip(trip) is a polymorphic method.

# Recognizing hidden ducks:
# There are some patterns that show that you may be able to use a duck type.
# 1 - Case statements that switch on class
# 2 - kind_of? and is_a?
# 3 - respond_to?

# Probably the most common and easiest to find the the number 1.
# Number 2 (kind_of? and is_a? are synonymous) do something similar to number
# 1 as they are checking for classes and should be dealt with in a similar way.
# Number 3 is an improvement as usually you won't be using directly the class
# name but still expects a very specific class so it is still very high in
# dependencies.

# In each of the 3 cases, the code is effectively saying, “I know who you are,
# and because of that, I know what you do.” This knowledge exposes a lack of
# trust in collaborating objects and acts as a millstone around your object’s
# neck. It introduces dependencies that make code difficult to change.

# When you create duck types, you must both document and test their public
# interfaces. Good tests are the best documentation as duck types are quite
# abstract.

# The duck type might only share the name of the message but not the
# implementation across classes. Of course in some cases the needs call for
# a shared implementation as well.

# Not all dependencies should be dealt with duck typing. For example, depending
# on core Ruby classes such as Array or NilClass is ok as it's very likely that
# they will change creating unexpected behavior.

# Changing base classes is known as monkey patching and is a delightful feature
# of Ruby but can be perilous in untutored hands. (*Nowadays we try to avoid*).

# Implementing duck types across your own classes is one thing, but changing
# Ruby base classes to introduce new duck types is quite another. The tradeoffs
# are different; the risks are greater. Neither of these considerations should
# prevent you from monkey patching Ruby at need; however, you must be able to
# eloquently defend this design decision. The standard of proof is high.

# As a reminder: Programming languages are either statically or dynamically
# typed. Most (though not all) statically typed languages require that you
# explicitly declare the type of each variable and every method parameter.
# Dynamically typed languages omit this requirement; they allow you to put any
# value in any variable and pass any argument to any method, without further
# declaration. Ruby, obviously, is dynamically typed.

# Messages are at the center of object-oriented applications, and they pass
# among objects along public interfaces. Duck typing detaches these public
# interfaces from specific classes, creating virtual types that are defined by
# what they do instead of by who they are.

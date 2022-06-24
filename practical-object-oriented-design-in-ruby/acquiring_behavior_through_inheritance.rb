# Well-designed applications are constructed of reusable code. Small,
# trustworthy self-contained objects with minimal context, clear interfaces, and
# injected dependencies are inherently reusable.

# Inheritance is, at its core, a mechanism for automatic message delegation. It
# defines a forwarding path for not-understood messages. It creates
# relationships such that, if one object cannot respond to a received message,
# it delegates that message to another.

class Bicycle
  attr_reader :size, :tape_color

  def initialize(**opts)
    @size = opts[:size]
    @tape_color = opts[:tape_color]
  end

  # every bike has the same defaults for
  # tire and chain size
  def spares
    { chain: '11-speed',
     tire_size: '23',
     tape_color: tape_color }
  end

  # Many other methods...
end

bike = Bicycle.new(
  size: 'M',
  tape_color: 'red')


puts bike.size
# => M

puts bike.spares
# => {:chain=>"11-speed", :tire_size=>"23", :tape_color=>"red"}

# For those unfamiliar with this syntax, know that **opts indicates that
# initialize will accept any number of keyword arguments and return them as a
# Hash. This leads to the opts references in lines 14 and 15.

# This class works just fine until something changes. For example, the need for
# a different type of Bicycle.

# If a class holds all the necessary information and you need to add something
# new based on that, it is tempting to just add the code directly into the same
# class and add conditions like if/else statement. This should be alarming as
# adding something new, after the new change, will require more conditions to
# be check and there will be very likely a lot of code repetition and unexpected
# things could happen on the initialization method depending on what data is
# passed at the beginning.

# Code that contains an if statement that checks an attribute that holds the
# category of self to determine what message to send to self reflects a pattern
# that indicates a missing subtype, better known as a subclass.

# The problem that inheritance solves: that of highly related types that share
# common behavior but differ along some dimension.

# It goes without saying that objects receive messages. No matter how
# complicated the code, the receiving object ultimately handles any message in
# one of two ways. It either responds directly or it passes the message on to
# some other object for a response.Inheritance provides a way to define two
# objects as having a relationship such that when the first receives a message
# that it does not understand, it automaticallyforwards, or delegates, the
# message to the second. It’s as simple as that.

# It depends on the object oriented language, but there is a difference in the
# real world and programming inheritance. In the world world you would normally
# have two parents that you inherit from, that is the case in some object
# oriented programming language and that case is called "multiple inheritance".
# It comes with big challenges such as what if they implement the same method?
# Which one takes priority? etc. To avoid this scenarios most object oriented
# language implement what is called "single inheritance", in this case the
# subclass is only allowed to have one parent superclass.

# Ruby works with single inheritance. A superclass may have many subclasses, but
# each subclass is permitted only one superclass.

# Message forwarding via classical inheritance takes place between classes.
# Because duck types cut across classes, they do not use classical inheritance
# to share common behavior. Duck types share code via Ruby modules.

# Every class you create is, by definition, a subclass of something.

# We have automatic delegation of messages in Ruby. A good example is the case
# of the #nil? method. This method is implemented in both the NilClass and the
# Object class. When nil.nil? is called, it uses the implementation in the
# NilClass returning true. When another object calls it, it goes all the way to
# the Object class and gets that implementation, which returns false.

# The fact that unknown messages get delegated up the superclass hierarchy
# implies that subclasses are everything their superclasses are, plus more. An
# instance of String is a String, but it’s also an Object. Every String is
# assumed to contain Object’s entire public interface and must respond
# appropriately to any message defined in that interface. Subclasses are thus
# specializations of their superclasses.

# For inheritance to work, two things must always be true. First, the objects
# that you are modeling must truly have a generalization–specialization
# relationship. Second, you must use the correct coding techniques.

# The superclass should be abstract in the sense that it shares code needed by
# the subclasses but it shouldn't receive a call to #new as it is not a complete
# version. Abstract classes exist to be subclassed. This is their sole purpose.
# They provide a common repository for behavior that is shared across a set of
# subclasses, subclasses that in turn supply specializations.

# Creating a hierarchy has costs; the best way to minimize these costs is to
# maximize your chance of getting the abstraction right before allowing
# subclasses to depend on it.

# Many of the difficulties of inheritance are caused by a failure to rigorously
# separate the concrete from the abstract.

# The general rule for refactoring into a new inheritance hierarchy is to
# arrange code so that you can promote abstractions rather than demote
# concretions. Meaning that instead of start with the superclass start with the
# subclass and try to notice which bits can be abstracted and put that into the
# abstract super class instead of starting from the super class and try to find
# the concrete bits that sub classes need.

# "Template method pattern": While wrapping the defaults in methods is good
# practice in general, these message sends serve a dual purpose. The superclass
# main goal in sending these messages is to give subclasses an opportunity to
# contribute specializations by overriding them. This technique of defining a
# basic structure in the superclass and sending messages to acquire
# subclass-specific contributions is known as the template method pattern.

# "Template method pattern" example:

class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(**opts)
    @size = opts[:size]
    @chain = opts[:chain] || default_chain
    @tire_size = opts[:tire_size] || default_tire_size
  end

  def default_chain # <- common default
    "11-speed"
  end
  # ...
end

class RoadBike < Bicycle
  # ...
  def default_tire_size # <- subclass default
    "23"
  end
end

class MountainBike < Bicycle
  # ...
  def default_tire_size # <- subclass default
    "2.1"
  end
end

# Any class that uses the template method pattern must supply an implementation
# for every message it sends, even if it's an error. Creating code that fails
# with reasonable error messages takes minor effort in the present but provides
# value forever. Each error message is a small thing, but small things
# accumulate to produce big effects, and it is this attention to detail that
# marks you as a serious programmer. Always document template method
# requirements by implementing matching methods that raise useful errors.

class Bicycle
  # ...
  def default_tire_size
    raise NotImplementedError,
    "#{self.class} should have implemented..."
  end
end

class RecumbentBike < Bicycle
  def default_chain
    '10-speed'
  end
end

bent = RecumbentBike.new(size: "L")
# => RecumbentBike should have implemented...
# => .../some_file.rb:15:in `default_tire_size'

# Instead of allowing subclasses to know the algorithm and requiring that they
# send super, superclasses can instead send hook messages, ones that exist
# solely to provide subclasses a place to contribute information by implementing
# matching methods. This strategy removes knowledge of the algorithm from the
# subclass and returns control to the superclass.

class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(**opts)
    @size = opts[:size]
    @chain = opts[:chain] || default_chain
    @tire_size = opts[:tire_size] || default_tire_size

  post_initialize(opts) # Bicycle both sends and implements this
  end

  def post_initialize(opts)
  end
  # ...
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(opts) # RoadBike can optionally override it
    @tape_color = opts[:tape_color]
  end
end

# This change doesn’t just remove the send of super from RoadBike’s initialize
# method, it removes the initialize method altogether. RoadBike no longer
# controls initialization; it instead contributes specializations to a larger,
# abstract algorithm. That algorithm is defined in the abstract superclass
# Bicycle, which in turn is responsible for sending post_initialize.

# RoadBike is still responsible for what initialization it needs but is no
# longer responsible for when its initialization occurs. This change allows
# RoadBike to know less about Bicycle, reducing the coupling between them and
# making each more flexible in the face of an uncertain future. RoadBike doesn’t
# know when its post_initialize method will be called, and it doesn’t care what
# object actually sends the message. Bicycle (or any other object) could send
# this message at any time; there is no requirement that it be sent during
# object initialization.Putting control of the timing in the superclass means
# the algorithm can change without forcing changes upon the subclasses.

# This same technique can be used to remove the send of super from the spares
# method. Instead of forcing RoadBike to know that Bicycle implements spares
# and that Bicycle’s implementation returns a hash, you can loosen coupling by
# implementing a hook that gives control back to Bicycle. The following example
# changes Bicycle’s spares method to send local_spares. Bicycle provides a
# default local_spares implementation that returns an empty hash. RoadBike takes
# advantage of this hook and overrides local_spares to contribute its own
# specific spare parts.

class Bicycle
  # ...
  def spares
    { tire_size: tire_size,
    chain: chain }.merge(local_spares)
  end

  # hook for subclasses to override
  def local_spares
    {}
  end
end

class RoadBike < Bicycle
  # ...
  def local_spares
    { tape_color: tape_color }
  end
end

# RoadBike’s new implementation of local_spares replaces its former
# implementation of spares. This change preserves the specialization supplied by
# RoadBike but reduces its coupling to Bicycle. RoadBike no longer has to know
# that Bicycle implements a spares method; it merely expects that its own
# implementation of local_spares will be called, by some object, at some time.

# Considering above's changes, and the same changes applied to MountainBike,
# the final hierarchy looks like this:

class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(**opts)
    @size = opts[:size]
    @chain = opts[:chain] || default_chain
    @tire_size = opts[:tire_size] || default_tire_size
    post_initialize(opts)
  end

  def spares
  { tire_size: tire_size, chain: chain }.merge(local_spares)
  end

  def default_tire_size
    raise NotImplementedError
  end

  # subclasses may override
  def post_initialize(opts)
  end

  def local_spares
    {}
  end

  def default_chain
    "11-speed"
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(opts)
    @tape_color = opts[:tape_color]
  end

  def local_spares
    { tape_color: tape_color }
  end

  def default_tire_size
    "23"
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def post_initialize(opts)
    @front_shock = opts[:front_shock]
    @rear_shock = opts[:rear_shock]
  end

  def local_spares
    { front_shock: front_shock }
  end

  def default_tire_size
    "2.1"
  end
end

road_bike =
  RoadBike.new(
  size: 'M',
  tape_color: 'red')

puts road_bike.tire_size # => 23
puts road_bike.chain # => 11-speed
puts road_bike.spares
# => {:tire_size=>"23", :chain=>"11-speed", :tape_color=>"red"}

mountain_bike =
  MountainBike.new(
  size: 'S',
  front_shock: 'Manitou',
  rear_shock: 'Fox')

puts mountain_bike.tire_size # => 2.1
puts mountain_bike.chain # => 11-speed
puts mountain_bike.spares
# => {:tire_size=>"2.1", :chain=>"11-speed", :front_shock=>"Manitou"}

# Adding new subclasses becomes really easy as they need only to implement the
# template methods (post_initialize, local_spares, default_chain,
# default_tire_size).

# As summary, inheritance solves the problem of related types that share a great
# deal of common behavior but differ across some dimension. It allows you to
# isolate shared code and implement common algorithms in an abstract class,
# while also providing a structure that permits subclasses to contribute
# specializations. The best way to create an abstract superclass is by pushing
# code up from concrete subclasses. Identifying the correct abstraction is
# easiest if you have access to at least three existing concrete classes. You
# are often better served to wait for the additional information that three
# cases supply.

# Abstract superclasses use the template method pattern to invite inheritors to
# supply specializations, and they use hook methods to allow these inheritors to
# contribute these specializations without being forced to send super. Hook
# methods allow subclasses to contribute specializations without knowing the
# abstract algorithm. They remove the need for subclasses to send super and
# therefore reduce the coupling between layers of the hierarchy and increase its
# tolerance for change.

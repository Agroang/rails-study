# To reap benefits from using inheritance you must understand not only how to
# write inheritable code but also when it makes sense to do so. Use of classical
# inheritance is always optional; every problem that it solves can be solved
# another way. Because no design technique is free, creating the most
# cost-effective application requires making informed tradeoffs between the
# relative costs and likely benefits of alternatives.
# This chapter explores an alternative that uses the techniques of inheritance
# to share a role.

# Some problems require sharing behavior among otherwise unrelated objects. This
# common behavior is orthogonal to class; it’s a role an object plays.

# When a role needs shared behavior, you’re faced with the problem of organizing
# the shared code. Ideally this code would be defined in a single place but be
# usable by any object that wished to act as the duck type and play the role.

# Methods can be defined in a module and then the module can be added to any
# object. Modules thus provide a perfect way to allow objects of different
# classes to play a common role using a single set of code.

# When an object includes a module, the methods defined therein become available
# via automatic delegation. If this sounds like classical inheritance, it also
# looks like it, at least from the point of view of the including object. From
# that object’s point of view, messages arrive, it doesn’t understand them, they
# get automatically routed somewhere else, the correct method implementation is
# magically found, it is executed, and the response is returned.

# The total set of messages to which an object can respond includes:
# • Those it implements
# • Those implemented in all objects above it in the hierarchy
# • Those implemented in any module that has been added to it
# • Those implemented in all modules added to any object above it in the
#   hierarchy

# It’s easiest to illustrate these dependencies with an extreme example. Imagine
# a StringUtils class that implements utility methods for managing strings.
# You can ask StringUtils if a string is empty by sending StringUtils.
# empty?(some_string).
# If you have written much object-oriented code you will find this idea
# ridiculous. Using a separate class to manage strings is patently redundant;
# strings are objects, they have their own behavior, they manage themselves.
# Requiring that other objects know about a third party, StringUtils, to get
# behavior from a string complicates the code by adding an unnecessary
# dependency.

# The rules for modules are the same as for classical inheritance. If a module
# sends a message, it must provide an implementation, even if that
# implementation merely raises an error indicating that users of the module must
# implement the method.

# This may not fit the strict definition of classical inheritance, but in terms
# of how the code should be written and how the messages are resolved, it
# certainly acts like it. The coding techniques are the same because method
# lookup follows the same path.

# Classic inheritance versus modules is like a "is-a" versus "behaves-like-a"
# difference definitely matters, and each choice has distinct consequences.
# However, the coding techniques for these two things are very similar and this
# similarity exists because both techniques rely on automatic message delegation.

# When Bicycle includes Schedulable, all of the methods defined in the module
# become part of Bicycle’s response set. The module’s methods go into the method
# lookup path directly above methods defined in Bicycle. Including this module
# doesn’t change Bicycle’s superclass (that’s still Object), but as far as
# method lookup is concerned, it may as well have. Any message received by an
# instance of MountainBike now stands a chance of being satisfied by a method
# defined in the Schedulable module.
# This has enormous implications. If Bicycle implements a method that is also
# defined in Schedulable, Bicycle’s implementation overrides Schedulable’s.

# When a single class includes several different modules, the modules are placed
# in the method lookup path in reverse order of module inclusion. Thus, the
# methods of the last included module are encountered first in the lookup path.

# This discussion has, until now, been about including modules into classes via
# Ruby’s include keyword. As you have already seen, including a module into a
# class adds the module’s methods to the response set for all instances of that
# class. For example, the Schedulable module was included into the Bicycle class,
# and, as a result, instances of MountainBike gain access to the methods defined
# therein.
# However, it is also possible to add a module’s methods to a single object,
# using Ruby’s extend keyword. Because extend adds the module’s behavior directly
# to an object, extending a class with a module creates class methods in that
# class and extending an instance of a class with a module creates instance
# methods in that instance. These two things are exactly the same; classes are,
# after all, just plain old objects, and extend behaves the same for all.

# Finally, any object can also have ad hoc methods added directly to its own
# personal “Singleton class.” These ad hoc methods are unique to this specific
# object.

# The usefulness and maintainability of inheritance hierarchies and modules is
# in direct proportion to the quality of the code.

# There are two antipatterns that indicate that your code might benefit from
# inheritance:
# First, an object that uses a variable with a name like type or category to
# determine what message to send to self contains two highly related but
# slightly different types.
# Second, when a sending object checks the class of a receiving object to
# determine what message to send, you have overlooked a duck type. This is
# another maintenance nightmare; the code must change every time you introduce a
# new class of receiver.

# All of the code in an abstract superclass should apply to every class that
# inherits it. Superclasses should not contain code that applies to some, but
# not all, subclasses. This restriction also applies to modules: The code in a
# module must apply to all who use it.

# Subclasses that override a method to raise an exception like “does not
# implement” are a symptom of this problem. While it is true that expediency
# pays for all and that it is sometimes most cost effective to arrange code in
# just this way, you should be reluctant to do so. When subclasses override a
# method to declare that they do not do that thing, they come perilously close
# to declaring that they are not that thing. Nothing good can come of this.
# If you cannot correctly identify the abstraction, there may not be one, and
# if no common abstraction exists, then inheritance is not the solution to your
# design problem.

# In order for a type system to be sane, subtypes must be substitutable for
# their supertypes.Following this principle creates applications where a
# subclass can be used anywhere its superclass would do and where objects that
# include modules can be trusted to interchangeably play the module’s role.

# The fundamental coding technique for creating inheritable code is the template
# method pattern. This pattern is what allows you to separate the abstract from
# the concrete. The abstract code defines the algorithms and the concrete
# inheritors of that abstraction contribute specializations by overriding these
# template methods.The template methods represent the parts of the algorithm
# that vary, and creating them forces you to make explicit decisions about what
# varies and what does not.

# Avoid writing code that requires its inheritors to send super; instead use
# hook messages to allow subclasses to participate while absolving them of
# responsibility for knowing the abstract algorithm. Inheritance, by its very
# nature, adds powerful dependencies on the structure and arrangement of code.
# Writing code that requires subclasses to send super adds an additional
# dependency; avoid this if you can. Hook methods solve the problem of sending
# super, but, unfortunately, only for adjacent levels of the hierarchy. If you
# have to add another subclass to a subclass you might have to end up using
# super to reach the super class method.

# The limitations of hook methods are just one of the many reasons to create
# shallow hierarchies.
# Every hierarchy can be thought of a pyramid that has both depth and breadth.
# An object’s depth is the number of superclasses between it and the top. Its
# breadth is the number of its direct subclasses. A hierarchy’s shape is defined
# by its overall breadth and depth, and it is this shape that determines ease of
# use, maintenance, and extension.

# Shallow, narrow hierarchies are easy to understand. Shallow, wide hierarchies
# are slightly more complicated. Deep, narrow hierarchies are a bit more
# challenging and unfortunately have a natural tendency to get wider, strictly
# as a side effect of their depth. Deep, wide hierarchies are difficult to
# understand, costly to maintain, and should be avoided.

# Because objects depend on everything above them, a deep hierarchy has a large
# set of built-in dependencies, each of which might someday change.

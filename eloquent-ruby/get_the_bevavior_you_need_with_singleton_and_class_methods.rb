# The class/instance approximation is exactly that, an approximation.

# Singleton methods allow you to produce objects with an independent streak,
# objects whose behavior is not completely controlled by their class.

# In Ruby, a singleton method is a method that is defined for exactly one
# object instance.

# You can hang a singleton method on just about any object at any time. The
# mechanics of defining singleton methods are really pretty simple: Instead of
# saying def method_name as you would to define a regular garden-variety method,
# you define a singleton method with def instance.method_name. If, for example,
# you wanted to create your own stub printer by hand, you could say this:

hand_built_stub_printer = Object.new

def hand_built_stub_printer.available?
  true
end

def hand_built_stub_printer.render( content )
  nil
end

# You could then call hand_built_stub_printer.available? and render

# Singleton methods are in all respects ordinary methods: They can accept
# arguments,  return values, and do anything else that a regular method can do.
# The only difference is that singleton methods are stuck to a single object
# instance.

# Singleton methods override any regular, class-defined methods. For example, if
# you run the (admittedly more fun than useful) code shown here:

uncooperative = "Don't ask my class"

def uncooperative.class
  "I'm not telling"
end

puts uncooperative.class
# => I'm not telling

# There is also an alternative syntax for defining singleton methods, one that
# can be less bulky if you are creating a lot of methods:

hand_built_stub_printer = Object.new

class << hand_built_stub_printer
  def available? # A singleton method
    true
  end

  def render # Another one
    nil
  end
end

# So how does Ruby pull off the singleton method trick? The key is that every
# Ruby object carries around an additional, somewhat shadowy class of its own.
# This more or less secret class—the singleton class—sits between every object
# and its regular class. The singleton class starts out as just a methodless
# shell and is therefore pretty invisible. It’s only when you add something to
# it that the singleton class steps out of the shadows and makes its existence
# felt.

# Since it sits directly above the instance, the singleton class has the first
# say on how the object is going to behave, which is why methods defined in the
# singleton class will win out over methods defined in the object’s regular
# class, and in the superclasses.

# Class methods are actually singleton methods.

def Document.explain
  puts "self is #{self}"
  puts "and its class is #{self.class}"
end

# Any given class, say, Document, is an instance of Class. This means that it
# inherits all kinds of methods from Class, methods like name and superclass.
# When we want to add a class method, we want that new method to exist only on
# the one class (Document in the example), not on all classes. Since the object
# that goes by the name of Document is an instance of Class, we need to create a
# method that exists only on the one object (Document) and not on any of the
# other instances of the same class. What we need is a singleton method.

# Once you get used to the idea that a class method is just a singleton method
# on an instance of Class, a lot of things that you learned in Ruby 101 start to
# make sense. For example, you will sometimes see the following syntax used to
# define class methods:

class Document
  class << self
    def find_by_name(name)
      # find document by name...
    end

    def find_by_id(doc_id)
      # find document by id...
    end
  end
end

# This code only makes sense in light of the class method = singleton method
# equation: It is simply the class << some_object syntax applied to the
# Document class.

# A common use for class methods is to provide alternative methods for
# constructing new instances. The Ruby library Date class, for example, comes
# with a whole raft of class methods that create new instances. You can, for
# example, get a date from the year, the month, and the day:

require 'date'
xmas = Date.civil( 2010, 12, 25 )

# Or by the year and the day of that year:
xmas = Date.ordinal( 2010, 359 )

# Or by the day, the week number, and the day of the week:
xmas = Date.commercial( 2010, 51, 6 )

# Plain, non class singleton methods are used in real life mainly for tests
# (mocks and stubs).

# Remember, when you define a class method, it is a method attached to a class.
# The instances of the class will not know anything about that method.
# You could still call it through the class, a bit of a hacky way, something
# like:

 book.class.method_from_class # book being an instance, and #class will give you
 # access to the class methods.

 # Because of this hacky ways, and inheritance sometimes it can be hard to keep
 # track of the value of self. The most important thing that you need you need
 # to remember is that the answer is that self is always the thing before the
 # period when you called the class method.

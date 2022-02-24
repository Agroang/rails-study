class D
  def x; 'x'; end
end
class D
  def y; 'y'; end
end

obj = D.new
obj.x # => "x"
obj.y # => "y

# Ruby executed the code within the class just as it would execute any other
# code. Does that mean you defined three classes with the same name? The
# answer is no.

# When the previous code mentions class D for the first time, no class by that
# name exists yet. So, Ruby steps in and defines the class—and the x method.
# At the second mention, class D already exists, so Ruby doesn’t need to define
# it. Instead, it reopens the existing class and defines a method named y there.

# Modify an existing class.
class String
  def my_string_method
    "my method"
  end
end

"abc".my_string_method # => "my method

# This technique is called "Open Class"

# Monkeypatch:
# Change the features of an existing class.

"abc".reverse # => "cba"
class String
  def reverse
    "override"
  end
end
"abc".reverse # => "override"
# You want to avoid this kind of things! Be sure that you are writing a new
# method and not overwriting one if you want to use Open Class

# Question: What about self.method_name for class methods? Wasn't that the way
# to define class methods?
# Answer: The method bellow is an instance method and not a class method, that's
# why you are calling it in obj, an instance of MyClass and not on MyClass
# directly.

class MyClass
  def my_method
  @v = 1
  end
end
obj = MyClass.new
obj.class # => MyClass

obj.my_method
obj.instance_variables # => [:@v]

# If you don't use #my_method you wouldn't have that @v from the call to
# #instance_variables

# Most objects inherit a number of methods from "Object" so usually their
# list of methods is quite long (obj.methods returns quite a long list).
# If you want to check if an specific method is present you can use #grep:

obj.methods.grep(/my/) # => [:my_method]

# “Objects that share the same class also share the same methods, so the methods
# must be stored in the class, not the object.” (objects are the instances of
# a class)

# Instance variables live in objects; methods live in classes!

# You should be aware of one important distinction about methods. You can
# rightly say that “obj has a method called my_method,” meaning that you’re able
# to call obj.my_method(). By contrast, you shouldn’t say that “MyClass has a
# method named my_method.” That would be confusing, because it  would imply that
# you’re able to call MyClass.my_method() as if it were a class method.

# To remove the ambiguity, you should say that my_method is an instance method
# (not just “a method”) of MyClass, meaning that it’s defined in MyClass, and
# you actually need an object (or instance) of MyClass to call it. It’s the same
# method, but when you talk about the class, you call it an instance method, and
# when you talk about the object, you simply call it a method. Remember this
# distinction, and you won’t get confused when writing introspective code like
# this:

String.instance_methods == "abc".methods # => true
String.methods == "abc".methods # => false

# Here is possibly the most important thing you’ll ever learn about the Ruby
# object model: classes themselves are nothing but objects.

# Because a class is an object, everything that applies to objects also applies
# to classes. Classes, like any object, have their own class, called—you guessed
# it—Class:

"hello".class # => String
String.class # => Class

# A Class in Ruby is quite literally the class itself, and you can manipulate it
# like you would manipulate any other object.

# You can call Class.new to create new classes while your program is running.
# This flexibility is typical of Ruby’s metaprogramming: while other languages
# allow you to read class-related information, Ruby allows you to write that
# information at runtime.
# ** Very powerful! **

# Like any object, classes also have methods. The methods of an object are also the
# instance methods of its class. In turn, this means that the methods of a class
# are the instance methods of Class:

# The "false" argument here means: ignore inherited methods
Class.instance_methods(false) # => [:allocate, :new, :superclass]

# You already know about new because you use it all the time to create objects.
# The allocate method plays a supporting role to new. Chances are, you’ll never
# need to care about it.

# On the other hand, you’ll use the superclass method a lot. This method is
# related to a concept that you’re probably familiar with: inheritance. A Ruby
# class inherits from its superclass.

Array.superclass # => Object
Object.superclass # => BasicObject
BasicObject.superclass # => nil

# The Array class inherits from Object, which is the same as saying “an array is
# an object.” Object contains methods that are generally useful for any object—
# such as to_s, which converts an object to a string. In turn, Object inherits
# from BasicObject, the root of the Ruby class hierarchy, which contains only a
# few essential methods.

# Question: What is the superclass of Class?
# Answer:
Class.superclass # Module
Module.superclass # Object
Object.superclass # => BasicObject
BasicObject.superclass # => nil

# The superclass of Class is Module—which is to say, every class is also a
# module. To be precise, a class is a module with three additional instance
# methods (new, allocate, and superclass) that allow you to create objects or
# arrange classes into hierarchies.

# Indeed, classes and modules are so closely related that Ruby could easily get
# away with a single “thing” that plays both roles. The main reason for having
# a distinction between modules and classes is clarity: by carefully picking
# either a class or a module, you can make your code more explicit. Usually,
# you pick a module when you mean it to be included somewhere, and you pick
# a class when you mean it to be instantiated or inherited. So, although you
# can use classes and modules interchangeably in many situations, you’ll
# probably want to make your intentions clear by using them for different
# purposes.

# There’s one more interesting detail in the “Classes are objects” theme: like
# you do with any other object, you hold onto a class with a reference. A
# variable can reference a class just like any other object:

my_class = MyClass

# MyClass and my_class are both references to the same instance of Class—the only
# difference being that my_class is a variable, while MyClass is a constant. To
# put this differently, just as classes are nothing but objects, class names are
# nothing but constants.

# Any reference that begins with an uppercase letter, including the names of
# classes and modules, is a constant. You might be surprised to learn that a
# Ruby constant is actually very similar to a variable—to the extent that you
# can change the value of a constant, although you will get a warning from the
# interpreter.

# The difference between constants and variables lies in their scope. Constants
# have a special set of rules.

module MyModule
  MyConstant = 'Outer constant'
  class MyClass
    MyConstant = 'Inner constant'
  end
end

# These two "MyConstant" are not the same!

# All the constants in a program are arranged in a tree similar to a file system,
# where modules (and classes) are directories and regular constants are files.
# Like in a file system, you can have multiple files with the same name, as long
# as they live in different directories. You can even refer to a constant by its
# path, as you’d do with a file.

# The path to constants:
# Constants’ paths use a double colon as a sepaparator (::)

module M
  class C
    X = 'a constant'
  end
C::X # => "a constant"
end
M::C::X # => "a constant"

# If you’re sitting deep inside the tree of constants, you can provide the
# absolute path to an outer constant by using a leading double colon as root:

Y = 'a root-level constant'

module M
  Y = 'a constant in M'
  Y # => "a constant in M"
  ::Y # => "a root-level constant"
end

# The Module class also provides an instance method and a class method that,
# confusingly, are both called constants. Module#constants returns all constants
# in the current scope, like your file system’s ls command (or dir command, if
# you’re running Windows). Module.constants returns all the top-level constants
# in the current program, including class names:

M.constants # => [:C, :Y] # C is a class but it's also a constant!
Module.constants.include? :Object # => true
Module.constants.include? :Module # => true

# Finally, if you need the current path, check out Module.nesting:
module M
  class C
    module M2
      Module.nesting # => [M::C::M2, M::C, M]
    end
  end
end

# The similarities between Ruby constants and files go even further: you can
# use modules to organize your constants, the same way that you use directories
# to organize your files.

# The earliest versions of Rake, the popular Ruby build system, defined classes
# with obvious names, such as Task and FileTask. These names had a good chance
# of clashing with other class names from different libraries. To prevent clashes,
# Rake switched to defining those classes inside a Rake module:

module Rake
  class Task
    # ...

# Now the full name of the Task class is:

Rake::Task

# which is unlikely to clash with someone else’s name. A module such as Rake,
# which only exists to be a container of constants, is called a "Namespace".

# Another example of the use of namespaces:

module MyNamespace
  class Array
    def to_s
      "my class"
    end
  end
end
Array.new # => []
MyNamespace::Array.new # => my class

# Objects & Classes Wrap-up:

# What’s an object? It’s a bunch of instance variables, plus a link to a class.
# The object’s methods don’t live in the object—they live in the object’s class,
# where they’re called the instance methods of the class.

# What’s a class? It’s an object (an instance of Class), plus a list of instance
# methods and a link to a superclass. Class is a subclass of Module, so a class is
# also a module.

# These are instance methods of the Class class. Like any object, a class has its
# own methods, such as new. Also like any object, classes must be accessed
# through references. You already have a constant reference to each class: the
# class’s name.

obj3 = MyClass.new
obj3.instance_variable_set("@x", 10) # This will give obj3 the instance variable
# of @x with the value of 10, interesting method

# What Happens When You Call a Method?

# When you call a method, Ruby does two things:
# 1. It finds the method. This is a process called "method lookup".
# 2. It executes the method. To do that, Ruby needs something called "self"

# Method Lookup:

# The receiver is the object that you call a method on. For example, if you
# write:
my_string.reverse() # then my_string is the receiver

# To understand the concept of an "ancestors chain", look at any Ruby class.
# Then imagine moving from the class into its superclass, then into the
# superclass’s superclass, and so on, until you reach BasicObject, the root of
# the Ruby class hierarchy. The path of classes you just traversed is the
# ancestors chain of the class.(The ancestors chain also includes modules)

# So, for Ruby to find a method ("Method Lookup") you need to use:
# 1 - the receiver
# 2 - the ancestors chain

# Ruby goes in the receiver’s class, and from there it climbs the ancestors
# chain until it finds the method.

class MyClass
  def my_method; 'my_method()'; end
end

class MySubclass < MyClass
end

obj = MySubclass.new
obj.my_method() # => "my_method()

# Question: Don't you need to add super or some kind of keyword to actually
# use the instance method defined in MyClass?

# When you call my_method, Ruby goes right from obj, the receiver, into MySubclass.
# Because it can’t find my_method there, Ruby continues its search by going up
# into MyClass, where it finally finds the method.
# this behavior is also called the “one step to the right, then up” rule: go one
# step to the right into the receiver’s class, and then go up the ancestors
# chain until you find the method.

# You can ask a class for its ancestors chain with the ancestors method:
MySubclass.ancestors # => [MySubclass, MyClass, Object, Kernel, BasicObject]

# Modules & Lookup:

# You learned that the ancestors chain goes from class to superclass. Actually,
# the ancestors chain also includes modules. When you include a module in a
# class (or even in another module), Ruby inserts the module in the ancestors
# chain, right above the including class itself:

module M1
  def my_method
    'M1#my_method()'
  end
end

class C
  include M1
end

class D < C; end
D.ancestors # => [D, C, M1, Object, Kernel, BasicObject]

# Starting from Ruby 2.0, you also have a second way to insert a module in a
# class’s chain of ancestors: the prepend method. It works like include, but it
# inserts the module below the including class (sometimes called the includer),
# rather than above it: (the order is different from above)

module M2
  def my_method
    'M2#my_method()'
  end
end

class C2
  prepend M2
end

class D2 < C2; end
D2.ancestors # => [D2, M2, C2, Object, Kernel, BasicObject]

# Multiple inclusions:

module M1; end

module M2
  include M1
end

module M3
  prepend M1
  include M2
end

M3.ancestors # => [M1, M3, M2] # Prepend goes first as it was prepended!

# In the previous code, M3 prepends M1 and then includes M2. When M2 also
# includes M1, that include has no effect, because M1 is already in the chain of
# ancestors. This is true every time you include or prepend a module: if that
# module is already in the chain, Ruby silently ignores the second inclusion.
# As a result, a module can appear only once in the same chain of ancestors.

# The Kernel module:

# Ruby includes some methods, such as print, that you can call from anywhere
# in your code. It looks like each and every object has the print method.
# Methods such as print are actually private instance methods of module Kernel:

Kernel.private_instance_methods.grep(/^pr/) # => [:printf, :print, :proc]

# The trick here is that class Object includes Kernel, so Kernel gets into every
# object’s ancestors chain. Every line of Ruby is always executed inside an
# object, so you can call the instance methods in Kernel from anywhere. This
# gives you the illusion that print is a language keyword, when it’s actually a
# method.
# ** Mindblown! **

# You can take advantage of this mechanism yourself: if you add a method to
# Kernel, this Kernel Method will be available to all objects.

module Kernel
  def a_method
    "a kernel method"
  end
end
a_method # => "a kernel method"

# Method Execution:

# When you call a method, Ruby does two things: first, it finds the method, and
# second, it executes the method. Up to now, you focused on the finding part.
# Now you can finally look at the execution part.

def my_method
  temp = @x + 1
  my_other_method(temp)
end

# To execute this method, you need to answer two questions. First, what object
# does the instance variable @x belong to? And second, what object should you
# call my_other_method on? (as humanas we know that is the receiver, but Ruby
# uses other ways to find out)

# The self Keyword:

# Every line of Ruby code is executed inside an object—the so-called current
# object. The current object is also known as self, because you can access it
# with the self keyword.

# Only one object can take the role of self at a given time, but no object holds
# that role for a long time. In particular, when you call a method, the receiver
# becomes self. From that moment on, all instance variables are instance
# variables of self, and all methods called without an explicit receiver are
# called on self. As soon as your code explicitly calls a method on some other
# object, that other object becomes self.

class MyClass
  def testing_self
    @var = 10 # An instance variable of self
    my_method() # Same as self.my_method()
    self
  end

  def my_method
    @var = @var + 1
  end
end

obj = MyClass.new
obj.testing_self # => #<MyClass:0x007f93ab08a728 @var=11>

# As soon as you call testing_self, the receiver obj becomes self. Because of
# that, the instance variable @var is an instance variable of obj, and the method
# my_method is called on obj. As my_method is executed, obj is still self, so
# @var is still an instance variable of obj. Finally, testing_self returns a
# reference to self.(self here includes that instance variable that's why it
# appears on the call to self on the last line of #testing_self)

# In most cases it's easy to track the current "self", that would be which
# object was the last method receiver. Nevertheless there are two important
# special cases.

# The Top Level:

# who’s self if you haven’t called any method yet? You can run irb and ask Ruby
# itself for an answer:

self # => main
self.class # => Object

# As soon as you start a Ruby program, you’re sitting within an object named
# main that the Ruby interpreter created for you. This object is sometimes called
# the top-level context, because it’s the object you’re in when you’re at the top
# level of the call stack: either you haven’t called any method yet or all the
# methods that you called have returned.

# Question: Is "main" the similar to "global()" in JavaScript?

# About private methods (extra piece of information):

# Private methods are governed by a single simple rule: you cannot call a private
# method with an explicit receiver. In other words, every time you call a private
# method, it must be on the implicit receiver—self.

class C
  def public_method
    self.private_method
  end

  private

  def private_method; end
end

C.new.public_method # NoMethodError: private method ‘private_method’ called [...]

# You can make this code work by removing the self keyword!

# This contrived example shows that private methods come from two rules working
# together: first, you need an explicit receiver to call a method on an object
# that is not yourself, and second, private methods can be called only with an
# implicit receiver. Put these two rules together, and you’ll see that you can
# only call a private method on yourself. You can call this the “private rule.”

# Can object "x" call a private method on object "y" if the two objects share
# the same class? The answer is no, because no matter which class you belong to,
# you still need an explicit receiver to call another object’s method.
# Can you call a private method that you inherited from a superclass? The answer
# is yes, because you don’t need an explicit receiver to call inherited methods
# on yourself.
# ** A little bit hard to grasp but I feel it's very important and the last
# part helps to understand better **

# Class Definitions and self:

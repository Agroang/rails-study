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

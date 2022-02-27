# The source code of a language is teeming with language constructs.
# In ruby, runtime is quite busy and you interact with the language constructs,
# ask them about themselves. This is called "introspection".
# You can get a lot of information on runtime because in Ruby objects and
# classes are first-class citizens.
# So, as you can see it's easy to read language constructs on runtime, but
# what about writing them on runtime? That's when metaprogramming comes into
# play.

# Extra information about setter/getter methods in Ruby class and what an
# equal (=) sign next to a method name means:
# http://ruby-doc.com/docs/ProgrammingRuby/html/tut_classes.html#UB

# Active Records is a good example of metaprogramming, it creates a lot for you
# by reading your code and then writes methods that will be available to you
# based on convention. It's incredibly powerful.

# A definition of metaprogramming would be:
# "Metaprogramming is writing code that manipulates language constructs at
# runtime"

# The authors of Active Record applied this concept. Instead of writing accessor
# methods for each class’s attributes, they wrote code that defines those
# methods at runtime for any class that inherits from ActiveRecord::Base.
# ("code that writes code" in few words)

# Ruby is a very metaprogramming-friendly language. It has no compile time
# at all, and most constructs in a Ruby program are available at runtime. You
# don’t come up against a brick wall dividing the code that you’re writing from
# the code that your computer executes when you run the program. There is
# just one world. (Other languages do not have this! There is a clear difference
# between compile and runtime and the things that are avaiable on each)

# You can modify existing classes by simply adding methods you want, check
# the_object_model.rb file for example.

# The class keyword in ruby is more like a scope operator. Of course you can
# define a class, but if already there, you can add define methods by calling
# it again.

# you can always reopen existing classes — even standard library classes such
# as String or Array—and modify them on the fly. You can call this technique:
# "Open Class".

# It is quite a common practice to use Open Classes this way to modify standard
# library classes.

# The dark side of Open Classes is that you can overwrite methods by mistake!
# If you casually add bits and pieces of functionality to classes, you can end
# up with bugs! Some people would frown upon this kind of reckless patching of
# classes, and they would refer to the previous code with a derogatory name:
# "Monkeypatch"

# Unlike in Java or other static languages, in Ruby there is no connection
# between an object’s class and its instance variables. Instance variables just
# spring into existence when you assign them a value, so you can have objects
# of the same class that carry different instance variables.

# Instance variables live in objects; methods live in classes!
# Let’s wrap it all up: an object’s instance variables live in the object itself,
# and an object’s methods live in the object’s class. That’s why objects of the
# same class share methods but don’t share instance variables.

# Here is possibly the most important thing you’ll ever learn about the Ruby
# object model: classes themselves are nothing but objects.

# You can create classes with Class.new on runtime, essential to Ruby's
# metaprogramming and something very powerful!

# The "false" argument here means: ignore inherited methods
# Class.instance_methods(false) # => [:allocate, :new, :superclass]
# A Ruby class inherits from its superclass.

# The main reason for having a distinction between modules and classes is clarity.
# Usually, you pick a module when you mean it to be included somewhere, and you
# pick a class when you mean it to be instantiated or inherited.

# Just as classes are nothing but objects, class names are nothing but constants.

# Constants: Any reference that begins with an uppercase letter, including the
# names of classes and modules, is a constant.

# One big difference between a variable and a constant is their scope. Constant
# have their own special set of rules when it comes to scope.
# Constants’ paths use a double colon as a sepaparator (::)

# "Namespace" is a module that act as a container of constants

# "include" and "prepend" are similar but "prepend" goes first when you are
# calling the ancestors's list of an specific constant. (Detailed info in the
# the_object_model file)

# The Kernel module, included in the Object class includes methods that you can
# call everyone in your code, such as print. So print is not actually a language
# keyword but a method!

# self refers to the current object receiver of a method, so self is always
# changing and the top level is "main"

# Private methods: Private methods are governed by a single simple rule: you
# cannot call a private method with an explicit receiver. In other words, every
# time you call a private method, it must be on the implicit receiver—self.

# Refinements are similar to Monkeypatches, but they’re not global. A
# Refinement is active in only two places: the refine block itself and the code
# starting from the place where you call using until the end of the module (if
# you’re in a module definition) or the end of the file (if you’re at the top
# level)

# Careful in the order that you include your modules, depending on that the
# chain of ancestors will change and you might be calling different methods
# if they share a common label!

# Usually you call methods through the dot notation but there is another way
# using the #send method. This is used for "Dynamic Methods". (More info on
# the methods.rb file)
# You can wait literally until the very last moment to decide which method to
# call, while the code is running. This technique is called "Dynamic Dispatch".

# About Dynamic Methods: Using Module.define_methods you can define methods at
# runtime and that is the biggest advantage over using the good ol' def keyword.

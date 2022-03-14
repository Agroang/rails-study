# Ruby is an object oriented programming language, which means that the world
# of Ruby is a world of objects, instances of Date and String and Document and a
# thousand other classes. As different as all these objects are bound to be, at
# some level they are all just objects.

# Every Ruby object is an instance of some class. Classes act as containers of
# methods. Classes are also factories. Factories for making instances of that
# class.

# Once you have an instance you can call instance methods on that instance with
# the very well known dot notation instance#method.

doc.count

# During a method call, Ruby sets self to the instance that you called the
# method on, so that if you added this to Document:

class Document
  # Most of the class on holiday...
  def about_me
    puts "I am #{self}"
    puts "My title is #{self.title}"
    puts "I have #{self.word_count} words"
  end
end

# And then ran doc.about_me, you would see something like:

# I am #<Document:0x8766ed4>
# My title is Ethics
# I have 4 words

# Ruby treats self as a sort of default object: When you call a method without
# an explicit object reference, Ruby assumes that you meant to call the method
# on self, so that a call to plain old word_count gets translated to
# self.word_count. You should rely on this assumption in your code: Don’t write
# self.word_count when a plain word_count will do.

# Every class—except one—has a superclass, someplace that the class can turn to
# when someone calls a method that the class doesn’t recognize. If you don’t
# specify a superclass when you are defining a new class, the new class
# automatically becomes a direct subclass of Object.

# Alternatively, you can specify a different superclass.

# The Ruby technique for resolving methods is straight out of the object
# oriented handbook: Look for the method in the class of the object. If it is
# there, call it and you are done. If not, move on to the superclass and try
# there. Repeat until you either find the method or run out of superclasses.

# Ruby is very consistent when it comes to OOP: Virtually everything is an object.

-3.abs # Here we are calling and #abs method on an instance of an Integer class
# so we are doing something like (-3).abs, -3 being an instance.

# So if you check the class (.class) you will see what kind of classes the are.
# You can even call .class on class and it will return Class (that's the name
# of the class).

# In Ruby, if you can reference it with a variable, it's an object.

# Actually, if you can reference it with a variable it’s probably not just an
# object, but an Object, an instance of the Object class.

# Ruby 1.9 added the BasicObject class, as the new superclass of Object.

# Instances of Object also inherit some more esoteric talents. For example, the
# eval method, defined by Object, takes a string and executes the string as if it
# were Ruby code. The possibilities with eval are literally limitless: Having
# eval around means that every Ruby programmer has the entire Ruby language
# available at a moment’s notice.

# The Object class also supplies a set of reflection-oriented methods, methods
# that let you dig into the internals of an object. We met one of these in the
# last chapter: the public_methods method, which returns an array of all the
# method names available on the object. There is also instance_variables, which
# will pull out the names of any instance variables buried in the object.

# Like a lot of object oriented programming languages, Ruby lets you control the
# visibility of your methods. Methods can either be public—callable by any code
# anywhere, or private, or protected.

# You can make your methods private by adding private before the method definition:

class Document
  # Most of the class omitted
  private # Methods are private starting here
  def word_count
    return words.size
  end
end

# Or by making them private after the fact:

class Document
  # Most of the class omitted

  def word_count
    return words.size
  end

  private :word_count
end

# Ruby’s treatment of private methods is a bit idiosyncratic. The rule is that
# you cannot call a private method with an explicit object reference. So if
# word_count was indeed private, then this:

n = doc.word_count

# Will throw an exception, since we tried to use an explicit object reference
# (doc) in the call.

# By restricting the way that private methods can be called, Ruby ensures that
# private methods can only be called from inside the class that defined them.

class Document
  # Most of the class omitted...
  def word_count
    return words.size
  end
  private :word_count
  # This method works because self is the right thing,
  # the document instance, when you call it.
  def print_word_count
    n = word_count
    puts "The number of words is #{word_count}"
  end
end

# The rules for protected methods are looser and a bit more complex: Any instance
# of a class can call a protected method on any other instance of the class.
# Thus, if we made word_count protected, any instance of Document could call
# word_count on any other instance of Document, including instances of subclasses
# like RomanceNovel. (More complex ....but actually not very used as far as I
# understood, so probably there *might* not be any need to use these).

# Remember that just because the rules say that you can’t call some private or
# protected method, well, you can still call it. Among the methods that every
# object inherits from Object is send. If you supply send with the name of a
# method and any arguments the method might need, send will call the method,
# visibility be damned:

n = doc.send( :word_count )

# The Ruby philosophy is that the programmer is in charge. If you want to declare
# some method private, fine. Later, if someone, perhaps you, wants to violate
# that privacy, fine again. You are in charge and presumably you know what you
# are doing.

# Once you start understanding Ruby you will notice that a lot of the things
# that you use/do are just method calls. Things like "require", "private", and
# even the "attr_accessor" are all methods.

# Your classes inherit about 50 or more methods from Object, so you need to
# know your Object class, if for no other reason than to stay out of its way.
# That way you won't be overwriting methods for example.

# Remember, a great way to avoid broken code is to have less of it. The code that
# you never write will work forever.

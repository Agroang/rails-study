# There are two alternatives that Ruby gives us for storing class-level data,
# the class variable, and the class instance variable.

# Class variables start with two @@ and are associated with a class instead
# of an ordinary instance. A nice thing about class variables is that they are
# visible to the instances of the class.

# Class variables have one big problem, the problem of "wandering variables".
# Depending on how you require a class, or even the order, or if two classes
# share a class variable name, you might get unexpected results, and because
# of this, in a sense, class variables are like global variables with a slightly
# restricted realm.

# The more controlled way of setting some values is to use class instance
# variables instead of class variables.

# Question: How often are class variables actually used? Any case that it might
# be better to use them over class instance varaibles?

# These are single @instance variables that happen to find themselves attached
# to a class object. Recall that inside a class method, self is always the class.

class Document
  @default_font = :times

  def self.default_font=(font)
    @default_font = font

  end

  def self.default_font
    @default_font
  end
end

# To get at the Document default font, all you need to do is call the right class
# method, which is exactly what the Document initialize method does:

def initialize(title, author)
  @title = title
  @author = author
  @font = Document.default_font
end

# Class instance variables are a very Ruby solution to the problem holding onto
# classwide values. There is no extra syntax and no elaborate special case rules:
# @default_font is simply an instance variable on an object. The only remotely
# interesting thing here is that the object happens to be a class.

# Remember that class methods are just singleton methods on a class object. The
# trick to defining class-level attributes is to make self be the Document
# singleton class first:

class Document
  @default_font = :times

  class << self
    attr_accessor :default_font
  end

  # Rest of the class omitted...
end

# Run this code and you will end up with a Document class that has a couple of
# class methods, one to get the default font and the other to set it.
# Tested, if you run Document.methods you will get #default_font and
# #default_font= methods, pretty cool!

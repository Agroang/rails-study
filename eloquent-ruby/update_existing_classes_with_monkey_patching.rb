# Ruby's open classes means that you can change the behavior of any class
# at any time.

# You an add new methods, you can delete methods, you can replace code of
# existing methods as well if you want to.

# Open classes—and the monkey patching technique that goes with them—is actually
# a very practical solution to a number of programming problems.

# If in a sense, Classes work just like variables in Ruby:

name = 'Peter'

name = 'Rob'

# If name has not already been defined, then the code snippet above will define
# it and set it to the string 'Issac'. Alternatively, if name is already defined,
# the line of code will set it to a new value ('Rob' in this case).

# Ruby classes work in exactly the same way. The first time you define a new
# class, you are, well, defining a new class. There’s nothing surprising there,
# but now for the interesting part. If you write another class statement for
# that same class, then you are not defining a new class. Rather, you are
# modifying the existing that class, the same one you defined in the first place.

class Car
end

class Car
  def mileage
    "lots of miles"
  end
end

# Even better, the changes you make to your classes will be felt instantly by
# all of the instances of the class.

# It is possible, and not that unusual, to redefine existing methods on Ruby
# classes. This works on the “last def wins” principal: If you reopen a class
# and define a method that already exists, the new definition overwrites the old.
# Ideally you would fix the class on the original file but if you must fix it
# right away for some reason then you can use this kind of approach.

# This technique of modifying existing classes on the fly goes by the name of
# "monkey patching".

# There is no rule against monkey patching Ruby’s built-in classes.
# If you are programming in Ruby and that thing is a class, you can change it.

# alias_method actually copies a method implementation, giving it a new name
# along the way.

# For example, our original Document class had a method called word_count. With
# alias_method, we can create a couple more methods that do exactly the same
# thing as word_count:

class Document
  # Stuff omitted...
  def word_count
    words.size
  end

  alias_method :number_of_words, :word_count
  alias_method :size_in_words, :word_count
  # Stuff omitted...
end

# With the above, the document class will have three methods that do the same
# thing.

# Aside from letting you easily give a method several different names,
# alias_method comes in handy when you are messing with the innards of an
# existing class. Here’s a version of our String monkey patch that uses
# alias_method to avoid reproducing the logic of the original + method:

class String
  alias_method :old_addition, :+

  def +( other )
    if other.kind_of? Document
      new_content = self + other.content
      return Document.new(other.title, other.author, new_content)
    end
    old_addition(other)
  end
end

# Something quite subtle is going on with the above code: The call to
# alias_method copies the implementation of the original + method, giving the
# fresh copy the name old_addition. Having done that, we proceed to override
# the + method, but -and here is the important part- old_addition continues to
# refer to the original unmodified implementation. When the new + methods calls
# old_addition, we are actually invoking the original + method, which does all
# of the boring string addition work. (*Interesting but not very easy to get..*).

# When you reopen a class, you can do anything you could have done the first
# time. In the same way that we aliased an existing method, we can make a public
# method private:

class Document
  private :word_count
end

# Or a private method public again:

class Document
  public :word_count
end

# We can even remove methods all together:

class Document
  remove_method :word_count
end

# As we have seen, Ruby classes are just like variables in Ruby, you can set
# them and leave them alone or you can fiddle with them as much as you need.

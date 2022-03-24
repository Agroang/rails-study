#  In Ruby you create code blocks by tacking them on to the end of a method
# call, like this:

do_something do
  puts "Hello from inside the block"
end

# Or if its in one line:

do_something { puts "Hello from inside the block" }

# *This chapter is mainly about blocks as iterators!*

# When you tack a block onto the end of a method call, Ruby will package up the
# block as sort of a secret argument and (behind the scenes) passes this secret
# argument to the method. Inside the method you can detect whether your caller
# has actually passed in a block with the block_given? method and fire off the
# block (if there is one) with yield:

def do_something
  yield if block_given?
end

# Blocks can take arguments, which you supply as arguments to yield, so that if
# you do this:

def do_something_with_an_arg
  yield("Hello World") if block_given?
end

do_something_with_an_arg do |message|
  puts "The message is #{message}"
end

# You will get:
"The message is Hello World"

# Finally, like most everything else in Ruby, code blocks always return a value—
# the last expression that the block executes—which your yielding method can
# either use or ignore as it sees fit.

def print_the_value_returned_by_the_block
  if block_given?
    value = yield
    puts "The block returned #{value}"
  end
end

print_the_value_returned_by_the_block { 3.14159 / 4.0 }

# => The block returned 0.7853975

# The difference between the do_something and do_something_with_an_arg methods
# and a real iterator method is simple: An iterator method calls its block once
# for each element in some collection, passing the element into the block as a
# parameter.

# A class can have as many iterator methods as make sense. You are also free to
# name your iterator method anything you like, but it does make good sense to
# follow the Ruby convention and name your most obvious or commonly used
# iterator each and give any other iterators a name like
# each_something_else.

# An aspect of iterators that beginners often overlook is that you can write
# iterators that run through collections that don’t actually exist, at least not
# all at the same time. The simplest example of this sort of thing is the times
# method that you find on Ruby integers:

12.times { |x| puts "The number is #{x}" }
# The number is 0
# The number is 1
# The number is 2
# The number is 3... (until 11, then it just returns 12)

# By following the convention and naming your iterators with each, you will be
# able to include the Enumerables module which grants you a lot of interesting
# and useful methods.

# The Enumerable module is a mixin that endows classes with all sorts of
# interesting collection-related methods. Here’s how Enumerable works: First,
# you make sure that your class has an each method, and then you include the
# Enumerable module in your class, like this:

class Document
  include Enumerable

  # Most of the class omitted...

  def each
    words.each { |word| yield( word ) }
  end
end

# The simple act of including Enumerable adds a plethora of collection-related
# methods to your class, methods that all rely on your each method. So, if you
# create an instance of the Enumerable-enhanced Document:

doc = Document.new('Advice', 'Harry', 'Go ahead make my day')

# Then you can find out whether your document includes a given word with
# doc.include?, so that doc.include?("make") will return true, but
# doc.include?("Punk") will return false. Enumerable also enhances your class
# with a to_a method that returns an array of all of the items, in our case
# words, in your collection. The Enumerable module also adds methods that help
# you find things in your collection, methods with names like find and find_all.

# If the elements in your collection define the <=> operator, you can use the
# Enumerable-supplied sort method, which will return a sorted array of all the
# elements in your collection. Since strings do indeed define <=>, we can get a
# sorted listof the words in our document with doc.sort. In all, Enumerable adds
# nearly 40 methods to your class—not a bad return on the effort of implementing
# one or two methods and mixing in a single module.

# Along with Enumerable, Ruby also comes with the Enumerator class. If you
# create an Enumerator instance, passing in your collection and the name of the
# iterating method, what you will get is an object that knows how to sequence
# through your collection using that method.
# This is super cool and interesting!

# For example, if you make a new Enumerator based on a Document instance and
# the each_character method:

doc = Document.new('example', 'russ', "We are all characters")
enum = Enumerator.new( doc, :each_character )

# Then you will end up with an object with all of the nice Enumerable methods
# based on the each_character method. Thus you can discover the number of
# characters in your document text:

puts enum.count

# Or sort the characters:

pp enum.sort

# To produce:

[" ", " ", " ", "W", "a", "a", "a", "a", "c", ...]

# Although the names are tricky, getting the hang of Enumerable and Enumerator
# is well worth the effort.

# Remember, the code block you get handed in your iterator method is someone
# else’s code. You need to regard the block as something akin to a hand grenade,
# ready to go off at any second. Some problems could be raises in between for
# example and ways to get our would be using ensure or break.

# When called from inside of a block, break will trigger a return out of the
# method that called the block. An explicit return from inside the block
# triggers an even bigger jump: It causes the method that defined (not called)
# the block to return. This is generally what you want to simulate breaking out
# of or returning from a built-in loop. Fortunately, like exceptions, both break
# and return will trigger any surrounding ensure clauses.

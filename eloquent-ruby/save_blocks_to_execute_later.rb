# So far in our adventures with code blocks we have used block_supplied? to
# determine whether someone has passed in a code block to a method and yield to
# fire off the block. As we have seen, block_supplied? and yield rely on the
# fact that Ruby treats a code block appended to the end of a method call as a
# sort of implicit parameter to the call, a parameter that only yield and
# block_supplied? know how to get at.

# However, implicitly is not the only way to pass blocks to your methods. If you
# add a parameter prefixed with an ampersand to the end of your parameter list,
# Rubywill turn any block passed into the method into a garden-variety parameter.
# After you have captured a block with an explicit parameter, you can run it by
# calling its call method. Here, for example, is a very simple method with an
# explicit code block parameter:

def run_that_block( &that_block )
  puts "About to run the block"
  that_block.call
  puts "Done running the block"
end

# The above is an explicit way to pass a block of code to your method.
# It’s also trivially easy to figure out whether the caller actually did pass in
# a block: Just check to see if the value of the block parameter is nil:
that_block.call if that_block

# Explicit block parameters make it easy to determine at a glance which methods
# expect a code block. Methods with an explicit code block parameter can also
# treat the block as an ordinary object instead of some freakish special case.
# Explicit code block parameters allow you to do something that is impossible
# with the implicit variety: When you use explicit block parameters, you can
# hold onto the block and store a reference to it like any other object. And
# that means you can execute the block later, perhaps much later, possibly long
# after the method that caught the block has returned.

class Document
  # Most of the class omitted...
  def on_save( &block )
    @save_listener = block
  end

  def on_load( &block )
    @load_listener = block
  end

  def load( path )
    @content = File.read( path )
    @load_listener.call( self, path ) if @load_listener
  end

  def save( path )
    File.open( path, 'w' ) { |f| f.print( @contents ) }
    @save_listener.call( self, path ) if @save_listener
  end
end

my_doc = Document.new( 'Block Based Example', 'russ', '' )

my_doc.on_load do |doc|
puts "Hey, I've been loaded!"
end

my_doc.on_save do |doc|
puts "Hey, I've been saved!"
end

# With this approach using the on_load and on_save methods has a nice
# declarative feel to it—concise and clear.

# Being able to capture a code block for later use opens ups other
# possibilities: For example, you can use saved code blocks for lazy
# initialization.

class BlockBasedArchivalDocument
  attr_reader :title, :author

  def initialize(title, author, &block)
    @title = title
    @author = author
    @initializer_block = block
  end

  def content
    if @initializer_block
      @content = @initializer_block.call
      @initializer_block = nil
    end
      @content
  end
end

# This latest implementation means we can still get our document contents from a
# file, like this:

file_doc = BlockBasedArchivalDocument.new( 'file', 'russ' ) do
  File.read( 'some_text.txt' )
end

# But we can also get them via HTTP:

google_doc = BlockBasedArchivalDocument.new('http', 'russ') do
  Net::HTTP.get_response('www.google.com', '/index.html').body
end

# Or even other methods, depending on what we pass through the block.

# By using a code block, we get the best of both worlds. We can conjure up the
# document contents in any way we want, and the conjuring is delayed until we
# actually need it.

# Sometimes it’s handy to produce a code block object right here, right now. You
# wantto get hold of the object version of a block, which is actually an
# instance of the Proc class, without creating a method to catch it. You might,
# for example, want to create a block object that you can use as the default
# value for your document listeners. Fortunately, Ruby supplies you with a
# method for just such an occasion: lambda.

# The idea behind the lambda method is that you pass it a code block and the
# method will pass the corresponding Proc object right back at you.


# Although calling Proc.new is nearly synonymous with lambda:

from_proc_new = Proc.new { puts "hello from a block" }

# It’s not quite synonymous enough. The object you get back from Proc.new
# differs from what you would get back from lambda in two key ways.
# 1 - Proc.new object is very forgiving of the number of arguments passed to
# its call method. In contrast, the call method on an object returned by lambda
# acts more like a regular method and will throw an exception if you mess up the
# argument count.
# 2 - Objects from Proc.new feature all of the interesting return, break, and
# next behavior. For example, if a Proc.new block executes an explicit return,
# Ruby will try to return not just from the block but from the method that
# created the block. This behavior is great for iterators, but it can be a
# disaster for applications that hang onto code blocks long after the method
# that created them has returned. In contrast, the Proc object returned from
# lambda acts more like a portable method—a return from a lambda wrapped block
# will simply return from the block and no further.

# If you want a block object that behaves like the ones that Ruby generates when
# you pass a couple of braces into a method, use Proc.new. If you want something
# that will behave more like a regular object with a single method, use lambda.

# You should keep in mind the stuff that you might be unconsciously dragging
# along with your blocks. Remember the scope!!

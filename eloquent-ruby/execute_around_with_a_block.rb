# Delivering code where it is needed is exactly what code blocks do so well.

class SomeApplication
  def do_something
    with_logging('load') { @doc = Document.load( 'resume.txt' ) }
    # Do something with the document...
    with_logging('save') { @doc.save }
  end

  # Rest of the class omitted...

  def with_logging(description)
    begin
      @logger.debug( "Starting #{description}" )
      yield
      @logger.debug( "Completed #{description}" )
    rescue
      @logger.error( "#{description} failed!!")
      raise
    end
  end
end

# This simple “bury the details in a method that takes a block” technique goes
# by the name of execute around. Use execute around when you have something—like
# the logging in the previous example—that needs to happen before or after some
# operation, or when the operation fails with a exception.

# "Execute around" uses a code block to interleave some standard bit of
# processing with whatever it is that the block does.

# You can also set up objects with an initialization block. You would add a
# yield inside the initialization method:

def initialize(title, author, content = '')
  @title = title
  @author = author
  @content = content
  yield( self ) if block_given?
end

# Using execute around for initialization is generally less about making sure
# that things happen in a certain sequence and more about making the code
# readable.

# A key part of doing a successful execute around method is paying attention to
# what goes into and what comes out of the code block (important - about scope).

# All of the variables that are visible just before the opening do or { are
# still visible inside the code block. Code blocks drag along the scope in which
# they were created wherever they go.

# A good rule of thumb is that the only arguments you should pass from the
# application into an execute around method are those that the execute around
# method itself, not the block, will use.

with_logging('load') { @doc = Document.load( 'resume.txt' ) }

def with_logging(description) # we just passed the description here
  begin
    @logger.debug( "Starting #{description}" )
  yield
  # ...
  end
end

# Similarly, there is nothing wrong with the execute around method passing
# arguments that originate in the method itself into the block; in fact, many
# execute around methods do exactly that. For example, imagine that you need a
# method that opens a database connection, does something with it, and then
# ensures that the connection gets closed.

def with_database_connection( connection_info )
  connection = Database.new( connection_info )
  begin
    yield( connection ) # connection created inside gets passed into the block
  ensure
    connection.close
  end
end

# Another thing you need to consider with execute around methods is that the
# application might want to return something from the block. To make that work
# you would need to do something like:

return_value = yield # This way you can capture the return value

# Exception handling is even more important with execute around than it is with
# iterators, because execute around is all about guarantees. The whole idea of
# execute around is that the caller is guaranteed that this will happen before
# the code block fires and that will happen after. Don’t let some stray
# exception sully the reputation of your method for absolutely, positively
# getting the job done.

# Execute around can help you cope with those times when you have code that
# frequently needs to come before or after some other code, or both. Execute
# around suggests that you build a method that takes a block; inside of that
# method you execute whatever code needs executing before and after you call the
# block.

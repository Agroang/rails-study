# Rake. RSpec. ActiveRecord models. A build tool, a testing utility, and a
# database interface library. All three are examples of a particular style of
# programming, the internal Domain Specific Language, or DSL. More than any
# other technique, the internal DSL has come to represent the easy eloquence of
# Ruby; each is an illustration of how the language allows you to create tools
# that can solve whole classes of problems.

# Instead of being pretty good at a lot of things, a DSL tries to be really
# great at one narrowly defined class of problems.

# If you do decide to go the DSL route, you have a choice to make. The
# traditional way to build a DSL is to get out your copy of “Parsers and
# Compilers for Beginners” and start coding a whole new language. Martin Fowler
# calls this traditional approach "the external DSL", external in the sense that
# the new language is separate or external from the implementation language. The
# downside of the external DSL approach is right out in the open: You need to
# build a whole new programming language. Building a brand-new programming
# language from scratch is not something to be undertaken lightly.

# The alternative is to build your DSL atop an existing language. You add so
# much support for solving problems in your chosen domain into an existing
# language that it starts to feel like a specialized tool. The beauty of this
# second approach is that you don’t need to recreate all of the plumbing of a
# programming language—it’s already there for you. Fowler’s term for this other
# kind of DSL is, logically enough, the internal DSL. Internal DSLs are internal
# in that the DSL is built right into the implementation language. The good news
# is that Ruby, with its “the programmer is always right” feature set and very
# flexible syntax, makes a great platform for building internal DSLs.

# Good scripts certainly have a very declarative, specialized language feel to
# them. This is the way that many Ruby internal DSLs are born: You set out to
# build a helpful class with a good API, and gradually that API gets so good
# that it forgets that it’s just an API.

class XmlRipper
  def initialize(&block)
    @before_action = proc {}
    @path_actions = {}
    @after_action = proc {}
    block.call( self ) if block
  end

  def on_path( path, &block )
    @path_actions[path] = block
  end

  def before( &block )
    before_action = block
  end

  def after( &block )
    @after_action = block
  end

  def run( xml_file_path )
    File.open( xml_file_path ) do |f|
      document = REXML::Document.new(f)
      @before_action.call( document )
      run_path_actions( document )
      @after_action.call( document )
    end
  end

  def run_path_actions( document )
    @path_actions.each do |path, block|
      REXML::XPath.each(document, path) do |element|
        block.call( element )
      end
    end
  end
end

# the instance_eval method is quite useful for DSL. We can rewrite the above
# class to use less code by using it:

class XmlRipper
  def initialize(&block)
    @before_action = proc {}
    @path_actions = {}
    @after_action = proc {}
    instance_eval( &block ) if block
  end

  # Rest of the class omitted..
end

# Since the on_path and before methods are defined on the XmlRipper instance,
# you can drop the initialization block argument and simply call on_path and
# after directly:

ripper = XmlRipper.new do
  on_path( '/document/author' ) do |author|
    author.text = 'J.R.R. Tolkien'
  end
  after { |doc| puts doc }
end

ripper.run( 'fellowship.xml' )

# If, instead of passing a block to instance_eval you feed it a string,
# instance_eval will evaluate the string as Ruby code. Here’s a new, slightly
# rewritten version of the XmlRipper class that can read the script from a file:

class XmlRipper
  def initialize_from_file( path )
    instance_eval( File.read( path ) )
  end

  # Rest of the class omitted...
end

ripper = XmlRipper.new
ripper.initialize_from_file( 'fix_author.ripper' )
ripper.run( 'fellowship.xml')

# By building a DSL, you’re going all out to make it easy for your user to do
# whatever the DSL does. Any programming technique that makes the job easier,
# that makes the code clearer, is fair game.

# Creating an internal DSL can help you squeeze a lot of power and flexibility
# out of very little code. The trick is to keep squarely focused on solving your
# real problem and avoid getting carried away with building a really cool syntax.

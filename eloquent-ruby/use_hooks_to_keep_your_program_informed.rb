# Metaprogramming—at least as it is practiced in the Ruby world—is a very
# workman set of coding techniques that allow you to get the results you need
# with less code.

# A Ruby hook is some way—sometimes by supplying a block and sometimes by just
# overriding a method—to specify the code to be executed when something specific
# happens.

class SimpleBaseClass
  def self.inherited( new_subclass )
    puts "Hey #{new_subclass} is now a subclass of #{self}!"
  end
end

class ChildClassOne < SimpleBaseClass
end

# => Hey ChildClassOne is now a subclass of SimpleBaseClass!

# Somewhat real use example:

class DocumentReader
  class << self
    attr_reader :reader_classes
  end

  @reader_classes = []

  def self.read(path)
    reader = reader_for(path)
    return nil unless reader
    reader.read(path)
  end

  def self.reader_for(path)
    reader_class = DocumentReader.reader_classes.find do |klass|
    klass.can_read?(path)
    end
    return reader_class.new(path) if reader_class
  nil
  end

  def self.inherited(subclass) # Populates reader_classes with the subclasses
    DocumentReader.reader_classes << subclass # using inherited!
  end
end

class YAMLReader < DocumentReader
  def self.can_read?(path)
    /.*\.yaml/ =~ path # true if the file ends with .yaml
  end

  def initialize(path)
    @path = path
  end

  def read(path)
    # Lots of simple YAML stuff omitted
  end
end

# Every time you define a new DocumentReader subclass—in other words, a new
# file reader—the DocumentReader inherited hook will go off and add the new
# class to the running list of readers. That list of reader classes is exactly
# what the code needs when it is time to find the correct reader for a file. The
# beauty of doing it this way is that the programmer does not need to maintain
# the list by hand. You simply make sure that all of the reader classes are
# subclasses of DocumentReader and things take care of themselves.

# The module analog of 'inherited' is 'included'. As the name suggests, included
# gets called when a module gets included in a class.

module WritingQuality
  def self.included(klass)
    puts "Hey, I've been included in #{klass}"
  end

  def number_of_cliches
    # Body of method omitted...
  end
end

# Remember that include will make the methods instance methods! If you need to
# have a mix of both class and instance methods that you want a class to have,
# you can make separate modules for class and for instance methods:

module UsefulInstanceMethods
  def an_instance_method
  end
end

module UsefulClassMethods
  def a_class_method
  end
end

class Host
  include UsefulInstanceMethods
  extend UsefulClassMethods
end

# The above works but is not very elegant. You can use more metaprogramming to
# use hooks and make things more elegant:

module UsefulMethods
  module ClassMethods
    def a_class_method
    end
  end

  def self.included( host_class )
    host_class.extend( ClassMethods )
  end

  def an_instance_method
  end

  # Rest of the module deleted...
end

class Host
  include UsefulMethods
end

# Would be nice to try to test the above... it is starting be a little bit
# complex but I can see where it is going!

# The #at_exit hook gets called just before the Ruby interpreter exits, and this
# is your last chance to get a word in before it’s all over. Using at_exit is a
# bit different from the other hooks we have seen. Instead of overriding
# something, with at_exit you just call at_exit with a block:

at_exit do
  puts "Have a nice day."
end

at_exit do
  puts "Goodbye"
end

# As shown above, you can have multiple blocks if you want/need to. If you do
# call at_exit more than once, then when your application is ready to exit
# each block will get called in “last in/first out” order.

# => "Goodbye"
# => "Have a nice day."

# #inherited, #included, #at_exit are among the most useful hooks. But you also
# others that are incredibly powerful such as #method_missing or others not
# that famous such as method_added to check for added methods to your class or
# even for changes in global variables with #trace_var.

# The ultimate Ruby hook probably is #set_trace_func. With this handy little
# method you can supply a block that will get called whenever a method gets
# called or returns, whenever a class definition is opened with the class
# keyword or closed with an end, whenever an exception get raised, and
# whenever—and here’s the kicker—a line of code gets executed.
# Nevertheless, it is too powerful so if you use it you will get a lot of data!

# Things to be careful with hooks: For example, the #inherited hook will be
# triggered for all the subclasses, so you need to be careful how you use it!

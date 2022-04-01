# Ruby classes are defined line by line, just like regular Ruby code. If you
# print the instance methods of a class before and after the method inside a
# class, you will notice that the first time before the method definition, the
# class won't have that method, but at the end of, after the defition, it will.

class LessEmpty
  pp instance_methods(false)

  def do_something
    puts "I'm doing something!"
  end

  pp instance_methods(false)
end

# => []
#    [:do_something]


# The same applies when we do monkey patching, we are re opening a class and
# change a method, that will be called after the line of the first definition,
# overriding it.

# You can make decisions on the way to define and use methods with this logic
# as well (super cool!):

class Document
  # Lots of code omitted...
  def save( path )
    File.open( path, 'w' ) do |f|
      f.puts( encrypt( @title ))
      f.puts( encrypt( @author ) )
      f.puts( encrypt( @content ))
    end
  end

  if ENCRYPTION_ENABLED
    def encrypt( string )
      string.tr( 'a-zA-Z', 'm-za-lM-ZA-L')
    end
  else
    def encrypt( string )
      string
    end
  end
end

# This code starts out with a mundane save method, which writes the data in
# the document out to a file, after running it through the encrypt method. The
# question is, which encrypt method? It’s the class-level logic that makes the
# decision. If the ENCRYPTION_ENABLED constant is true, we end up with an
# encrypt method that does indeed shuffle the contents of the string. On the
# other hand, if ENCRYPTION_ENABLED isn’t true, we get an encrypt method that
# does nothing. Critically, the ENCRYPTION_ENABLED logic runs exactly once, when
# the class is loaded.

# The code that executes inside a class definition has something in common with
# a class method: They both execute with self set to the class. This suggests
# that we can use class methods to make the same kind of structural changes that
# we have done so far with class-level logic, and so we can. Here is our
# encryption example again, this time wrapped in a class method:

ENCRYPTION_ENABLED = true

class Document
  # Most of the class left behind...
  def self.enable_encryption( enabled )
    if enabled
      def encrypt_string( string )
        string.tr( 'a-zA-Z', 'm-za-lM-ZA-L')
      end
    else
      def encrypt_string( string )
        string
      end
    end
  end

  enable_encryption( ENCRYPTION_ENABLED ) # Creates the encrypt_method here
end

# This code does the very recursive trick of defining a class method, enable_
# encryption, which itself defines an instance method. Actually, it defines one
# of two versions of the encrypt_string method, depending on whether the enabled
# parameter is passed in as true or false. The last line of the class definition
# calls enable_encryption, passing in true, thereby starting us off with
# encrypting turned on. A handy side effect of this latest implementation is
# that we can toggle encryption off and on by calling the class method from
# outside. Thus, if we wanted to be sure that we were going to write
# encryption-free documents we could run:

Document.enable_encryption(false)

# And we would have the “do nothing” version of the encrypt_string method.

# While regular code needs unit tests, metaprogramming code absolutely cries out
# for them!

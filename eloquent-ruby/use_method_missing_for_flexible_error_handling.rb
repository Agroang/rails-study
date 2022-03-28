# Ideally, a good error-handing system will have some default behavior, but
# will also let you vary that behavior if you need to.

# method_missing is a feature of Ruby that allows you to handle a particular
# error condition: Someone has called a method that does not in fact exist.

# When Ruby fails to find a method, it turns around and calls a second method.
# This second call, to a method with the somewhat odd name of
# method_missing, is what eventually generates the exception: It’s the default
# implementation of method_missing, found in the Object class that raises the
# NameError exception.

# You are free to override method_missing in any of your classes and handle
# the case of the missing method yourself (this is what makes it so interesting
# and useful in some cases!)

class RepeatBackToMe
  def method_missing( method_name, *args )
    puts "Hey, you just called the #{method_name} method"
    puts "With these arguments: #{args.join(' ')}"
    puts "But there ain't no such method"
  end
end

# As you can see from this code, method_missing gets passed the name of the
# original method that was called along with the augments it was called with.

# You can give them a customized message if they call a bad method:

class Document
  # Most of the class omitted...
  def method_missing( method_name, *args )
    msg = %Q{
    You tried to call the method #{method_name}
    on an instance of Document. There is no such method.
    }
    raise msg
  end
end

# Or log the error for further analysis:

class Document
  # Most of the class omitted...
  def method_missing( method_name, *args )
    File.open( 'document.error', 'a' ) do |f|
    f.puts( "Bad method called: #{method_name}" )
    f.puts( "with #{args.size} arguments" )
    end
    super
  end
end

# const_missing works a lot like method_missing: It gets called whenever Ruby
# detects a reference to an undefined constant. It only takes one argument (a
# symbol containing the name of the missing constant). It also needs to be a
# a class method.

class Document
  # Most of the class omitted...
  def self.const_missing( const_name )
    msg = %Q{
      You tried to reference the constant #{const_name}
      There is no such constant in the Document class.
    }
    raise msg
  end
end

# In my most cases you won't need (or shouldn't use) method_missing or
# const_missing (powerful but dangerous as well). Save the fancy method_missing
# for those cases where you really do need to do something fancy with the error.

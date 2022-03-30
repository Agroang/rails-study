# In the programming world delegation is the idea that an object might secretly
# use another object to get part of the job done.

# We will see that method_missing provides an almost painless mechanism for
# delegating calls from one object to another.

# Sometimes you find yourself building an object that wants to do something and
# you happen to have another object that does exactly that something. You could
# copy all of the code from one class to the other, but that is probably a bad
# idea. Instead, what you do is delegate: You supply the first object with a
# reference to the second, and every time you need to do that something you call
# the right method on the other object. Delegation is just another word for
# foisting the work on another object.

# In programming as in management, the key to delegation is getting out of the
# way. The secret to getting out of the way lies in method_missing.

class SuperSecretDocument
  def initialize(original_document, time_limit_seconds)
    @original_document = original_document
    @time_limit_seconds = time_limit_seconds
    @create_time = Time.now
  end

  def time_expired?
    Time.now - @create_time >= @time_limit_seconds
  end

  def check_for_expiration
    raise 'Document no longer available' if time_expired?
  end

  def method_missing(name, *args)
    check_for_expiration
    @original_document.send(name, *args)
  end
end

# When the SuperSecretDocument method_missing catches a method call it uses the
# send method to forward the call onto the original document.

# The method_missing method will catch whatever methods you throw at
# SuperSecretDocument and will forward them, whatever they are, to the Document
# instance.

# The SuperSecretDocument class is effectively a perishable container for any
# object you might come up with.

# Instead of dealing with all the methods, you can also set selected methods
# you want to deal with.

class SuperSecretDocument
  # Lots of code omitted...
  DELEGATED_METHODS = [ :content, :words ]

  def method_missing(name, *args)
    check_for_expiration
    if DELEGATED_METHODS.include?( name )
    @original_document.send(name, *args)
    else
      super
    end
  end
end

# This rendition of SuperSecretDocument has a list of the names of the methods
# it wants to delegate to @original_document. If a method call comes in for some
# other method, we just call super, which forwards the original method call
# (arguments and all!) up the class hierarchy where it will eventually meet its
# fate with a NameError exception.

# One thing that we need to be really cautious about using method_missing is the
# fact that actually the method won't be missing, but actually exists but as it
# not on the list of the methods that you want to handle, end up getting trapped
# in the call the missing_method. To help with this what you can do is to
# inherit directly from BasicObject, as this class has only a handful of methods
# allowing you have more control over the methods that you want to handle and
# how.

# There is also a SimpleDelegator class that you can use that is already inside
# the Ruby library. Wirth checking out if you are interested in doing something
# like this.

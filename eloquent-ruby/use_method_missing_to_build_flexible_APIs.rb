# Think about what method_missing does: It lets you know that someone is trying
# to call a method on your object, a method that does not actually exist.

# What if, whenever someone called a nonexistent method on one of your objects,
# you looked at the method name to see whether you could make sense out of it?
# If you can, you do the right thing. If not, there is always NameException to
# raise.

class FormLetter < Document
  def replace_word( old_word, new_word )
    @content.gsub!( old_word, "#{new_word}" )
  end

  def method_missing( name, *args )
    string_name = name.to_s
    return super unless string_name =~ /^replace_\w+/
    old_word = extract_old_word(string_name)
    replace_word( old_word, args.first )
  end

  def extract_old_word( name )
    name_parts = name.split('_')
    name_parts[1].upcase
  end
end

# This variation on method_missing is sometimes called magic methods, since
# users of the class can make up method names and, as long as the names comply
# with the rules coded into method_missing, the methods will just magically work.

# One of the key values of the Ruby programming culture is that the
# look of the code matters. It matters because the people who use the code, read
# the code, and maintain the code matter.

# You need to be aware of the likelihood that using method_missing will muck up
# the respond_to? method. Every Object instance includes a method called
# respond_to? which should return true if the object in question has a
# particular method.

# The problem is that the default implementation of respond_to? only knows about
# the real methods; it has no way of knowing that you have slapped a
# method_missing on your class that will allow instances to cheerfully handle
# doc.replace_gender. Depending on how elaborate your method_missing
# implementation is, you may be able to fix respond_to?:

def respond_to?(name)
  string_name = name.to_s
  return true if string_name =~ /^replace_\w+/
  super
end

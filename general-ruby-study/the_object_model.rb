class D
  def x; 'x'; end
end
class D
  def y; 'y'; end
end

obj = D.new
obj.x # => "x"
obj.y # => "y

# Ruby executed the code within the class just as it would execute any other
# code. Does that mean you defined three classes with the same name? The
# answer is no.

# When the previous code mentions class D for the first time, no class by that
# name exists yet. So, Ruby steps in and defines the class—and the x method.
# At the second mention, class D already exists, so Ruby doesn’t need to define
# it. Instead, it reopens the existing class and defines a method named y there.

# Modify an existing class.
class String
  def my_string_method
    "my method"
  end
end

"abc".my_string_method # => "my method

# This technique is called "Open Class"

# Monkeypatch:
# Change the features of an existing class.

"abc".reverse # => "cba"
class String
  def reverse
    "override"
  end
end
"abc".reverse # => "override"
# You want to avoid this kind of things! Be sure that you are writing a new
# method and not overwriting one if you want to use Open Class

# Question: What about self.method_name for class methods? Wasn't that the way
# to define class methods?

# Like classes in most other object oriented programming languages, Ruby classes
# are arranged in an inheritance tree, so that a key part of constructing a new
# class is picking its parent, or superclass.

# Mixins allow you to easily share common code among otherwise unrelated
# classes. Mixins are custom-designed for those situations where you have a
# method or six that need to be included in a number of different classes that
# have nothing else in common.

# Sometimes, especially in cases where you have inherited large bodies of code,
# it’s just not practical to rewire the basic structure of your classes in order
# to share a few tens of lines of code.

# The way to solve the problem of sharing code among otherwise unrelated classes
# is by creating a mixin module.

# When you include a module into a class, the module’s methods magically become
# available to the including class.

include ModuleName # inside the class that you want to use the methods on

# The Ruby jargon is that by including a module in a class you have mixed it in
# to the class. A very useful aspect of mixins is that they are not limited by
# the “one superclass is all you get” rule. You can mix as many modules into a
# class as you like. All you need to do is wrap the common stuff in a module
# and include that module in the classes that need it.

# Sometimes it’s the class itself—as opposed to the instances of the class—that
# needs help from a module. Sometimes you want to pull in a module so that all
# the methods in the module become class methods.

# To make the methods into Class methods you could do the trick of using
# singleton methods, something like:
class Document
  class << self
    include ModuleName
  end
end

# But this is such a common pattern that there is a special keyword that we can
# use to do the same job: "extend".

class Document
  extend ModuleName
end

# So, include for instance methods and extend for class methods.
# Modules become a kind-of superclass of the class, so you will be able to see
# them if you use the #ancestors on that class.

# Include a module and it becomes the nearest parent “class” of the including
# class. Include a second module and it becomes the nearest parent of the
# including class, bumping the other module into second place. Include a module
# and it becomes the nearest parent “class” of the including class. Include a
# second module and it becomes the nearest parent of the including class,
# bumping the other module into second place.

# Since mixing in a module sets up an inheritance relationship between
# the including class and the module, you need to let your users know what that
# relationship is going to be before they start mixing. You should always add a
# few concise comments to your creation stating exactly what it expects from its
# including class.

# Mixin modules are also very convenient places to stash constants. Since
# including a module in a class inserts the module into the class hierarchy, the
# including class not only gains access to the module’s methods but also to its
# constants.

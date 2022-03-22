# A Ruby module is the container part of a class without the factory. You can't
# instantiate a module you can put things inside a module.

# Modules can hold methods, constants, classes, and even other modules.

# Wrapping a module around your classes gives you a couple of advantages.
# It allows you to group related classes together. And also, you dramatically
# reduce the possibility of class name collision (having the same name).

# As previously mentioned, you can also put constants inside the modules, and
# to access it you use the same syntax that you use to access classes within
# modules:

ModuleName::ClassName
ModuleName::CONSTANT_NAME

# Modules can be nested so you can have nested modules inside other modules.

FirstModule::SecondModule::ClassName

# You can avoid having to write so much by "including" the module inside a
# class for example.

include FirstModule

# Modules make great home for methods that do not seem to fit anywhere else.
# You can access those methods with :: but is better to use the . notation for
# methods.

FirstModule::random_method # Works but not recommended
FirstModule.random_method # This is better

# Just like pretty much everything in Ruby, modules are also objects, so you
# point to them using a variable and call that variable instead of the module.

the_module = FirstModule

the_module::ClassName.new

# Most of the dangers involved in actually creating name-space modules are
# easily avoidable. For example, if you want to enclose stand-alone utility
# methods in a module, make sure that you define those methods as module-level
# methods.

module WordProcessor

  def self.points_to_inches( points )
    points / 72.0
  end

  # etc...
end

# NOT THIS:

module WordProcessor
  def points_to_inches( points )
    points / 72.0
  end

  # etc...
end

# The first version of WordProcessor creates a module-level method that any code
# can use. The second version creates a method that might be great when mixed
# into a class but is useless as a widely available utility method.

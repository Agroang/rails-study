# Rails methods:
# (A lot of incredibly useful methods in ActiveSupport::Inflector)

# String#constantize
# constantize tries to find a declared constant with the name specified in the
# string. It raises a NameError when the name is not in CamelCase or is not
# initialized.
'Module'.constantize  # => Module

# String#humanize
# Capitalizes the first word, turns underscores into spaces, and (by default)
# strips a trailing '_id' if present. Like titleize, this is meant for creating
# pretty output.
'employee_salary'.humanize # => "Employee salary"

# String#classify
# Creates a class name from a plural table name like Rails does for table names
# to models. Note that this returns a string and not a class. (To convert to an
# actual class follow classify with constantize.)
'ham_and_eggs'.classify # => "HamAndEgg"


# Module#delegate
# delegate(*methods, to: nil, prefix: nil, allow_nil: nil, private: nil)
# Provides a delegate class method to easily expose contained objects' public
# methods as your own.
# Options
# :to - Specifies the target object name as a symbol or string
# :prefix - Prefixes the new method with the target name or a custom prefix
# :allow_nil - If set to true, prevents a Module::DelegationError from being
# raised
# :private - If set to true, changes method visibility to private

class Greeter < ActiveRecord::Base
  def hello
    'hello'
  end

  def goodbye
    'goodbye'
  end
end

class Foo < ActiveRecord::Base
  belongs_to :greeter
  delegate :hello, to: :greeter
end

Foo.new.hello   # => "hello"
Foo.new.goodbye # => NoMethodError: undefined method `goodbye' for #<Foo:0x1af30c>
# There is a LOT of information about it, maybe check further if needed:
# https://devdocs.io/rails~6.1/module#method-i-delegate

# POROS = Plain Old Ruby Objects

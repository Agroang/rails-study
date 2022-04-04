# Built into all Ruby classes, the class_eval method takes a string and
# evaluates it as if it were code that appeared in the class body. as "def"
# needs data and not a variable to create a method, you can bypass this problem
# by using class_eval and create methods on the fly.

class StructuredDocument
  def self.paragraph_type( paragraph_name, options )
    name = options[:font_name] || :arial
    size = options[:font_size] || 12
    emphasis = options[:font_emphasis] || :normal
    code = %Q{
      def #{paragraph_name}(text)
      p = Paragraph.new(:#{name}, #{size}, :#{emphasis}, text)
      self << p
      end
      }
    class_eval( code )
  end
  # ...
end

# Using the above call would be something like this'

class Instructions < StructuredDocument
  paragraph_type( :introduction,
  :font_name => :arial,
  :font_size => 18,
  :font_emphasis => :italic )
  # And so on...
end

# The paragraph_type method starts by pulling the font name, size, and emphasis
# out of the options hash, filling in defaults as needed. Now for the
# interesting part: The paragraph_type method creates a string that contains the
# code for the new introduction instance method, a string that will look
# something like this:

def introduction(text)
  p = Paragraph.new(:arial, 18, :italics, text)
  self << p
end

# Finally, paragraph_type uses class_eval to execute the string, which creates
# the introduction method. Note that the new method ends up on the
# StructuredDocument subclass (i.e., Instructions) and not on the
# StructuredDocument class itself because the whole process started with a call
# from inside the Instructions class, which set self to Instructions.

# Although creating new methods by class_eval’ing a string has a certain clarity
# to it—if nothing else, you can print out the string and actually see the
# method that you’re defining—it is really not ideal. We generally like to avoid
# “evaluate some code on the fly”-type methods if there is a more normal API
# alternative.

# The alternative for class_eval is define_method. To use define_method, you
# call it with the name of the new method and a block. You end up with a new
# method with the given name that will execute the block when called.
# Conveniently, the parameters of the block become the parameters of the new
# method.

# Redefining our method using define_method instead of class_eval:

class StructuredDocument
  def self.paragraph_type( paragraph_name, options )
    name = options[:font_name] || :arial
    size = options[:font_size] || 12
    emphasis = options[:font_emphasis] || :none
    define_method(paragraph_name) do |text|
      paragraph = Paragraph.new( name, size, emphasis, text )
      self << paragraph
    end
  end
  # ...
end

# Either way, class_eval or define_method works and you will end up with a
# method in the superclass that can add methods to its subclasses.
# You could even create private methods with the same logic:

class StructuredDocument
  # Rest of the class omitted...
  def self.privatize
    private :content
  end
end

# And then call #privatize from within the subclass:

class BankStatement < StructuredDocument
  paragraph_type( :bad_news,
  :font_name => :arial,
  :font_size => 60,
  :font_emphasis => :bold )

  privatize
end

# This would make the #content method of the BankStatement instance private.

# Some real examples of Ruby actually using this kind of approaches of making
# methods for you is on the attr_accessor for example:

class Printer
  attr_accessor :name
end

# What Ruby does under the hood is:

class Printer
  def name
    @name
  end

  def name=(value)
    @name = value
  end
end

# Other examples are Rail's ActiveRecords, you get a lot of methods for free
# with it that are linked to conventions!

# Metaprogramming can dramatically reduce the volume and the complexity of your
# code. Hooks let you define code that will run at helpful times. Method missing
# and the techniques that rely on open classes can save you an enormous amount
# of coding toil. All of this, however, comes at a price. Those hooks might go
# off at unexpected times. Using method missing and open classes means that your
# application will be running code that has no obvious counterpart in your
# source tree.

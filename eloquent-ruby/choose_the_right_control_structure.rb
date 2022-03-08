# Ruby does have the regular "if/else"/"while" statement but comes a few others that
# are not used in other languages, conditionals such as "unless" / "until".

def title=( new_title )
  unless @read_only
    @title = new_title
  end
end

# With unless, the body of the statement is executed only if the condition is
# false. It takes time to actually think in this "negative" way but it becomes
# very useful in the long run.

#"unless" is the negative of the "if" statement. "until" is the negative of the
# "while" statement.

# An until loop keeps going until its conditional part becomes true.

while !document.is_printed?
  document.print_next_page
end

# Becomes

until document.printed?
  document.print_next_page
end

# We can make even shorter version of both unless/until

@title = new_title unless @read_only

document.print_next_page until document.printed?

# (You can also do it with the while/if)

@title = new_title if @writable

document.print_next_page while document.pages_available?

# The important bit of the last examples is that not only is shorter but also
# reads very nice, it's easy to understand!

# Although Ruby does have a "for" loop method, it is not very used and we tend
# to prefer the #each method

fonts = [ 'courier', 'times roman', 'helvetica' ]
fonts.each do |font|
  puts font
end

# The logic is that: When you say "for font in fonts", Ruby will actually
# conjure up a call to fonts.each. Given that the for statement is really a call
# to each in disguise, why not just pull the mask off and write what you mean?

# Ruby also has a "case" statement, similar to the JavaScript "switch" statement.
# Ruby’s case statement has a surprising number of variants. Most commonly it is
# used to select one of a number of bits of code to execute:

case title
when 'War And Peace'
  puts 'Tolstoy'
when 'Romeo And Juliet'
  puts 'Shakespeare'
else
  puts "Don't know"
end

# Alternatively, you can use a case statement for the value it computes:

author = case title
        when 'War And Peace'
          'Tolstoy'
        when 'Romeo And Juliet'
          'Shakespeare'
        else
        "Don't know"
        end

# Or the equivalent, and somewhat more compact:

author = case title
        when 'War And Peace' then 'Tolstoy'
        when 'Romeo And Juliet' then 'Shakespeare'
        else
          "Don't know"
        end

# A case statement returns the values of the selected when or else clause—or nil
# if no when clause matches and there is no else.

# A case statement uses the === for comparison, so you can use it for classes as
# well.

case doc
when Document
  puts "It's a document!"
when String
  puts "It's a string!"
else
  puts "Don't know what it is!"
end

# In the same spirit, you can use a case statement to detect a regular
# expression match:

case title
when /War And .*/
  puts 'Maybe Tolstoy?'
when /Romeo And .*/
  puts 'Maybe Shakespeare?'
else
  puts 'Absolutely no idea...'
end

# There is a sort of degenerate version of the case statement that lets you
# supply your own conditions. But then it becomes pretty much a if/else
# statement and it is prefered to use that over the case.

case
when title == 'War And Peace'
  puts 'Tolstoy'
when title == 'Romeo And Juliet'
  puts 'Shakespeare'
else
  puts 'Absolutely no idea...'
end

# Remember, when you are making decisions in Ruby, only false and nil are treated
# as false. Because of this, it is not recommended to look for "true" as pretty
# much everything is. On the other hand, is better to look specifically for nil
# if you are expecting a nil, and not for false, as nil is also false.

# Another type of conditional statement is the ternary operator:

file = all ? 'specs' : 'latest_specs'

# The ?: operator acts like a very compact if statement with the condition part
# coming right before the question mark. If the condition (in the example, the
# value of all) is true, then the value of the whole expression is the thing
# between the question mark and the colon—'specs' in the example. If the
# condition is false, then the expression evaluates to the last part, the bit
# after the colon, 'latest_specs' in the example.


# Another common expression-based idiom helps with a familiar initialization
# problem: Sometimes you are just not sure if you need to initialize a variable.
# For example, you might want to ensure that an instance variable is not nil. If
# the variable has a value you want to leave it alone, but if it is nil you want
# to set it to some default:

@first_name ||= ''

# The logic behind is the same as the count += 1 logic:

@first_name = @first_name || ''

# Translated into English, the expansion says “Set the new value of @first_name
# to the old value of @first_name, unless that is nil, in which case set it to
# the empty string.”

# Finally, be aware that this use of ||= suffers from exactly the kind of nil/false
# confusion. If @first_name happened to start out as false, the code would
# cheerfully go ahead and reset it to the empty string. Moral of the story:
# Don’t try to use ||= to initialize things to booleans.

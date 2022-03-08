# Good code is not just clear, it is also concise!
# Good Ruby code should speak for itself, and most of the time you should let it
# do its own talking
# Remember, good code is like a good joke: It needs no explanation.

# In most cases you should use lowercase_words_separated_by_underscores
# (snake case)
# Class names use CamelCase
# Constant can be ALL_CAPS or CamelCase

# When you define or call a method you are free to ignore the parentheses
# Of course you can also add the parentheses!

def random_method param1, param2
  # some code to execute
end

random_method 1, 2


# Although this isn’t a hard and fast rule, most Ruby programmers surround the
# things that get passed into a method with parentheses, both in method
# definitions and calls. Somehow, having those parentheses there makes the
# code seem just a bit clear.

# When it comes to one line or to methods that are very well known, you can
# leave the parentheses out.

puts 'Look Ma, no parentheses!'

# Same applies to methods without arguments, you don't pass an empty parentheses
# you just leave it without parentheses.

def method_with_no_args
  'No arguments here'
end

# Same apply to conditionals, like "if" statement, we leave the parentheses
# outside (no parentheses)

if words.size < 100
  puts 'The document is not very long.'
end

# In Ruby we try to keep the statements per line, although it is possible to
# use more than one statement per line if we use a ";"

puts doc.title; puts doc.author

# You can do the same with very simple classes & methods

class DocumentException < Exception; end

def method_to_be_overriden; end

# The goal is code that is clear as well as concise. Nothing ruins readability
# like simply jamming a bunch of statements together because you can.

# When we talk about blocks ({} or do/end) although they do exactly the same
# we make a difference on when to use them. If your block consists of a single
# statement, fold the whole statement into a single line and delimit the block
# with braces. Alternatively, if you have a multistatement block, spread the
# block out over a number of lines, and use the do/end form.

10.times { |n| puts "The number is #{n}" }

10.times do |n|
  puts "The number is #{n}"
  puts "Twice the number is #{n*2}"
end

# In the case of having a line statement that gets too long, even if parentheses
# are not needed, it is better to use to make things clear.

puts doc.instance_of? self.class.superclass.class

# Easier to understand
puts doc.instance_of?( self.class.superclass.class )

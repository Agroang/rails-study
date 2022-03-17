# The Ruby mechanism for defining your own operators is straightforward and
# based on the fact that Ruby translates every expression involving programmer
# definable operators into an equivalent expression where the operators are
# replaced with method calls. So, the following:

sum = first + second

# Translates into:

sum = first.+(second)

# So sum will be the evaluation of calling the + method on first with the
# argument of second

# The Ruby interpreter is clever about the operator-to-method translation
# process and will make sure that the translated expression respects operator
# precedence and parentheses:

result = first + second * (third - fourth)

# Translates into:

result = first.+(second.*(third.-(fourth)))

# What this means is that creating a class that supports operators boils down
# to defining a bunch of instance methods, methods with names like +, -, and *.

# There are binary (do their thing in a pair of objects )and unary operators
# (to their thing in 1 object). Some operators can be both depending on how
# you use them.

# It’s easy to see the dual role of + and - with numeric expressions. In the
# expression -(2+6), the minus sign is a unary operator that simply changes the
# sign of the final result while the plus sign is a binary operator that adds
# the numbers together. But rewrite the expression as +(2-6) and the operator
# roles are reversed.

# To define a binary operator you would do something like:

def +(other)
  # do something with the other..
end

# To create the unary operator, you need to define a method with the special
# (and rather arbitrary) name +@. The same pattern applies to -: The plain
# old - method defines the binary operator while -@ defines the unary one.

def @+(other)
  # do something with other
end

# You can do something similar with arrays and hashes as well. When you say
# foo[4] you are really calling the [] method on foo, passing in four as an
# argument. Similarly, when you say foo[4] = 99, you are actually calling
# the []= method on foo, passing in four and ninety-nine.

# One nice thing about the unary operators is that you only need to deal with one
# object—and one class—at a time. Coping with two objects doesn’t present much
# of a challenge if you are dealing with two objects of the same class, but
# binary operators that work across classes can be one of those “seems simple
# until you try it” kind of jobs.

# If you want to define binary operators that work across classes, you need to
# either make sure that both classes understand their responsibilities or accept
# that your expressions will be sensitive to the order in which you write them.

# Operators are nice because they are an easy way of firing off a complicated set
# of ideas in the head of anyone reading your program. Write this very simple
# code:

a + b

# And you have, with a single character, conjured up a whole cloud of ideas in
# your readers’ heads, a cloud that goes by the name addition. Very convenient,
# but also a bit dangerous. The danger lies in knowing just how big the cloud is
# and exactly where its boundaries are.

# In few words, there are a lot of assumptions when it comes to operators so you
# need to be careful with that as a developer.

# Your Ruby installation also has some more exotic operator specimens like the
# formatting operator (%). The formatting operator is great when you need to
# construct a string and you need more control than the usual Ruby "string
# #{interpolation}" gives you.

"The value of n is %d" % 42
# => "The value of n is 42"

# The %d in the string signals that this is the place where the value on the
# right side of the % operator should be inserted.

# The beauty of the format operator is that it gives you very fine control over
# how the values get inserted into the string.

day = 4
month = 7
year = 1776

file_name = 'file_%02d%02d%d' % [ day, month, year ]
# => file_04071776

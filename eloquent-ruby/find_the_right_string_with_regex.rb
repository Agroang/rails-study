# In most cases, you can use the already available String methods to search
# for something, some kind of iteration, but using regex is way faster saving
# you a lot of code lines.

# Sometimes regex can be quite complex, but there is logic behind and some
# stuff can be quite easy.

# The regular expression x will match x.
# The regular expression aaa will match three a’s all in a row.
# The regular expression 123 will match the first three numbers.
# The regular expression R2D2 will match the name of a certain sci-fi robot.

# By default, case (upcased/downcased) is important for regular expressions,
# so 'x' won't match 'X'.

# Unlike letters and numbers, most of the special characters have a special
# meaning in regex. For example, the period or dot character matches any single
# character.

# In the same way, two periods ( .. ) will match any two characters, perhaps xx
# or 4F or even [!, but won’t match Q since it’s one, not two, characters long.

# You use a backslash to turn off the special meanings of the punctuation
# characters. Thus:

# The regular expression \. will match a literal dot.
# 3\.14 will match the string version of PI to two decimal places, complete with
# the decimal point: 3.14
# Mr\. Olsen will match exactly one thing: Mr. Olsen

# One of the interesting things about regex is that you can convine different
# expression to build complex (or "more" complex) patterns.

# The regular expression A. will match any two-character string that starts with
# a capital A, including AM, An, At, and even A=.
# Similarly, ...X will match any four-character string that ends with an X,
# including UVWX and XOOX.
# The regular expression .r\. Smith will match both Dr. Smith as well as
# Mr. Smith but not Mrs. Smith.

# One of the most useful patterns for regex are the "sets".  Sets match any one
# of a bunch of characters. To create a regular expression set, you wrap the
# characters in square brackets: Thus the regular expression [aeiou] will match
# any single lowercase vowel. The key word there is single: Although [aeiou] will
# match the single character a or the single character i, it will not match ai,
# since ai is two characters long.

# The regular expression [0123456789] will match any single digit.
# [0123456789abdef] will match any single hexadecimal digit, like 7 or f.

# More practically, you could use [0123456789abcdef][0123456789abcdef] to
# pick out a two-digit hexadecimal number like 3e or ff.

# You can also use [aApP][mM] to match am or PM and anything in between, like aM
# or Pm

# At some point you realize that this patterns are getting too long, and that's
# what the "range" is for.

# As the name suggests, you define a range by specifying the beginning and end of
# a sequence of characters, separated by a dash. So the range [0–9] will match
# exactly what you expect: any decimal digit. Similarly, [a-z] will match any
# lowercase letter. You can also combine several ranges together and mix them
# with the regular set notation, so that:

# [0-9abcdef] will match a single hexadecimal digit.
# [0-9a-f] will also match a single hexadecimal digit.
# [0-9a-zA-Z_] will match any letter, number, or the underscore character.

# There are even shortcuts for the most common sets of ranges:

# Instead of [0-9] you can use \d, so that \d\d will match any two digit number
# from 00 to 99.

# \w stands for "word character" and it will match any lettern, number or the
# underscore.

# \s will match any white space, including vanilla space, tab, and the new line.

# You can also use alternatives in regex with the | character. The expression
# will match either the thing before the bar or the thing after it.

# A|B will match either A or B

# You can also specify as many options as you like:

# A\.M\.|AM|P\.M\.|PM will match A.M. or AM, or P.M. or PM.

# You can also surround your alternatives in parentheses to set them off from
# the rest of the pattern:

# The (car|boat) is red
# Will match both The car is red as well as The boat is red.

# In regular expressions, an asterisk (*) matches zero or more of the thing that
# came just before it. Pause and think that through for a minute ...zero or more
# of the thing that came just before the asterisk. What this means is that A*
# will match zero or more A’s.

# AB* will match A, AB , but also ABB and ABBBBBBBBBBBB (you follow...)

# You are allowed to put the (*) not only at the end but wherever you want.

# R*uby matches  uby, Ruby, RRuby, and RRRRRRRuby (and more...)

# You can also the (*) with sets.

# The expression [aeiou]* will match any number of vowels: The whole [aeiou]
# set is the thing that came before the star.
# Likewise, the expression [0–9]* will match any number of digits.
# And [0-9a-f]* will match any number of hexadecimal digits.

# Likely the most widely used regex is .*

# This little gem—just a dot followed by an asterisk—will match any number of any
# characters, or to put it another way, anything.

# As an example, the regular expression George.* will match the full name of
# anyone whose first name is George.


# Regex in Ruby:

# To make a Ruby regex you encase your pattern between forward slashes /pattern/

# You use the =~ operator to test whether a regular expression matches a string.
puts /\d\d:\d\d (AM|PM)/ =~ '10:24 PM'
# => Returns 0, this means that the regex matched starting at index 0.
# The above expression scans the whole string looking for matches and wehen it
# finds something it returns the starting index of the match.

# If there is no match, then you will get a nil back

# Since =~ returns a number when it finds a match and nil if it doesn’t, you can
# use regular expression matches as booleans: (remember that numbers are truthy
# and that only false and nil are false in Ruby, you can make use of this to
# your favor!)

the_time = '10:24 AM'
puts "It's morning!" if /AM/ =~ the_time
# => "It's morning!"

# The =~ operator is also ambidextrous: It doesn’t matter whether the string or
# the regular expression comes first, so we could rephrase the last example as:

puts "It's morning!" if '10:24 AM' =~ /AM/

# You can turn that case sensitivity off my sticking an i on the end of your
# expression.

puts "It matches!" if /AM/i =~ 'am'
# => "It matches!"

# You can also use regex with the String methods that involve searching. One
# of those is for example the #gsub method.

def obscure_times!
  @content.gsub!( /\d\d:\d\d (AM|PM)/, '**:** **' )
end

# It's really nice that you can use the =~ to scan the whole string but you can
# also limit your search to the end or the beginning of the string.

# Will match a string only if it begins like a fairy tale. Note that the \A
# doesn’t match the first character. Instead, it matches the unseen leading edge
# of the string.
/\AOnce upon a time/

# Similarly, \z (note the lower case) matches the end of the string
/and they all lived happily ever after\z/
# Will only match a string that ends like a classic fairy tale.

# In the case that you are targetting, for example, the beginning of a line
# Fortunately, there a Regexp for that too: the circumflex (^). The circumflex
# character matches two things: the beginning of the string or the beginning of
# any line within the string.

puts "Found it" if content =~ /^Once upon a time/

# Similarly, the dollar sign $ matches the end of the string or the end of any
# line within the string.

puts "Found it" if content =~ /happily ever after\.$/

# Multiline strings pose one more challenge to regular expressions, specifically
# to the dot: By default, the dot will match any character except the newline
# character.

/^Once upon a time.*happily ever after\.$/
# The above won't work if it's multilined

# But you can turn off this behavior by adding /m
/^Once upon a time.*happily ever after\.$/m

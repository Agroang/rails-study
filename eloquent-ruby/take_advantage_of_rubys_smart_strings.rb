# Sometimes you have to mix "" and '' for certain strings, and even scape
# some with \. In those cases, it is better to just use the arbitrary quote
# mechanism (%q)

str = '"Stop", she said, "I can\'t live without \'s and "s."'

# Becomes:

str = %q{"Stop", she said, "I can't live without 's and "s."}

# The {} are in this case just delimiters, and you can pretty much use any other
# speciail character and it should work as long as you you use in both the start
# and the end.

# %q will get you '' and %Q will get you "".


# One nice feature of all Ruby strings is that they can span lines:

a_multiline_string = "a multi-line
string"

another_one = %q{another multi-line
string}

# Keep in mind that if you don’t do anything about it, you will end up with
# embedded newlines in those multiline strings. You can cancel out the newlines
# in double-quoted strings (and the equivalent %Q form) with a trailing backslash:

yet_another = %Q{another multi-line string with \
no newline}

# Finally, if you happen to have a very long multiline string, consider using a
# here document. A here document allows you to create a (usually long) string by
# sticking it right in your code:

heres_one = <<EOF
This is the beginning of my here document.
And this is the end.
EOF
# => "This is the beginning of my here document.\nAnd this is the end.\n"

# Just like collections such as Arrays and Hashes, Strings also have a lot of
# different methods to be learned and used.

' hello'.lstrip # returns a new string without the leading white space
'hello '.rstrip # returns a new string without the white space at the end
' hello '.strip # returns a new string without the white space at the beginning
# and at the end

# Similar to the above, we also have chomp and chop methods. #chomp deletes at
# most 1 new line after the string, so if you want to delete more than one you
# would have to add more #chomp

"It was a dark and stormy night\n".chomp
# => "It was a dark and stormy night"

# Be careful not to confuse #chomp with the #chop method. The #chop method will
# simply knock off the last character of the string, no matter what it is.

"hello".chop
# => "hell", this is also a new string so it doesn't modify the original one

# Other very useful methods are #upcase and #downcase. These two modify the
# original string! Careful with that.

"hello".upcase
# => "HELLO"

"HELLO".downcase
# => "hello"

# Another interesting one is #swapcase, that returns a string modified swaping
# uppercases for lowercases and viceversa

"TeSt".swapcase
# => "tEsT"

# You also have methods to change the content of a string. One of these is #sub.

"hello my friend".sub("hello", "goodbye")
# => "goodbye my friend"

# Something to be careful with this is that #sub with change at most 1 match,
# so if you need to change the same pattern multiple times then you need to use
# gsub.

"hello hello hello my friend".gsub("hello", "goodbye")
# => "goodbye goodbye goodbye my friend"

# Sometimes you want to separate your strings and one way to do it is using the
# #split method.

'It was a dark and stormy night'.split
# => ["It", "was", "a", "dark", "and", "stormy", "night"]

# If you pass an argument to the split method, it will break the string based on
# the pattern that you passed to it (it works as a delimiter)

'Bill:Shakespeare:Playwright:Globe'.split(':')
# => ["Bill", "Shakespeare", "Playwright", "Globe"]


# You can also locate things within a string using for example the #index method

"It was a dark and stormy night".index( "dark" )
# => 9 (thats the index for the start of the "dark" word)

# Strings are also a collection, just like Hashes and Arrays. They are a
# collection of characters. You also have methods that work with all the
# characters like

@author = 'clarke'
@author.each_char {|c| puts c}
# c
# l
# a
# r
# k
# e

# (my own test, you can also make use of other methods to link together such
# as #with_index)
author = 'clarke'
author.each_char.with_index {|c, i| puts"#{c} and its index is #{i}"}
# c and its index is 0
# l and its index is 1
# a and its index is 2
# r and its index is 3
# k and its index is 4
# e and its index is 5

# You also have methods that check for the bytes of each character, or even ones
# that check for the lines of your string if you have more than 1.

content = "this is a two lined \nstring, interesting stuff"
content.each_line { |line| puts line }
# "this is a two lined"
# string, interesting stuff

# Interestingly, since the “collection of what?” question is not one that can
# really be answered for strings, Ruby’s string class omits the plain old #each
# method

# As we have seen here, there are methods that return a new string and others
# that actually modify the string itself, so you need to be careful with String
# as they are mutable, and that may take a lot of people by surprise!

first_name = 'Karen'
given_name = first_name
given_name[0] = 'k'
# => first_name now is 'karen', super dangareous.
# In this case we need to use methods that return a copy of the original string
# something like first_name = first_name.upcase, instead of
# first_name = first_name.upcase! that will also modify the original one

# Just like the example above showed, you can use indexes and even ranges with
# strings

"abcde"[3..4]
# => "de"

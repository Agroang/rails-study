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

# Another API to Master .....

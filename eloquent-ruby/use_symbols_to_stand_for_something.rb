# If you are using some characters to stand for something in your code, you
# probably are not very interested in messing with the actual characters.
# Instead, in this second case you just need to know whether this thing is the
# flag that tells you to find all the records or just the first record. Mainly,
# when you want some characters to stand for something, you simply need to know
# if this is the same as that, quickly and reliably.

# Ruby String class is optimized for the data processing side of strings while
# symbols are meant to take over the “stands for” role—hence the name. Because
# of this distinction, they lack most of the classic string manipulation methods.

# Symbols do have some special talents that make them great for being symbols.
# For example, there can only ever be one instance of any given symbol: If I
# mention :all twice in my code, it is always exactly the same :all.

a = :all
b = a
c = :all
# a, b, and c, they all refer to the same object.

# The same doesn't happen with strings, even if they "look" the same you are
# likely creating a new string (new object in memory).

# The fact that there can only be one instance of any given symbol means that
# figuring out whether this symbol is the same as that symbol is not only
# foolproof, it also happens at lightning speeds.

# Symbols are immutable so you can also use them with confidence. You cannot for
# example change a letter inside it, or capitalize it, etc.
# Since symbol comparison runs at NASCAR speeds and symbols never change, they
# make ideal hash keys.

# Sometimes it's ok to use strings for keys within hashes, the reason is that
# the Hash class has special defenses built in to guard against just this kind
# of thing (mutating the string). Inside of Hash there is special case code that
# makes a copy of any keys passed in if f the keys happen to be strings.
# But it would make more sense to simply use symbols from the start.

# If needed, it is easy to turn a symbol into a string and vice versa using
# #to_s and #to_sym

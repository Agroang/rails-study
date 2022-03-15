# One of the oft-repeated advantages of dynamic typing is that it allows you to
# write more compact code.

# Compact code is a great thing, but compact code is by no means the only
# advantage of dynamic typing.

# Dynamic typing is related to the concept of "Duck Typing" that, in few words,
# it means that "if it quacks and swims like a duck, it must be a duck". The
# logic is to use methods with the same name on different classes, but those
# methods do different things according to each class. It's quite powerful
# but at the same time risky, you need to understand that you are calling
# different methods if they seem to be the same (both classes support the same
# set of methods and that’s what counts.)

# In Ruby, any two classes that can work together will work together.

# When you are coding, anything that reduces the number of revolving mental
# plates is a win. From this perspective, a typing system that you can sum up in
# a short phrase, “The method is either there or it is not,” has some definite
# appeal. If the problem is complexity, the solution might just be simplicity.

# when type declarations are required, you need put them in your code whether
# they make your code more readable or not—that’s why they call it required.
# Required type declarations inevitably become a ceremonial part of your code,
# motions you need to go through just to get your program to work. In contrast,
# making up for the lost documentation value of declarations in Ruby is easy:
# You write code that is painfully, blazingly obvious. Start by using nice, full
# words for class, variable, and method names.

# If that doesn’t help, you can go all the way and throw in some comments.

# With dynamic typing, it’s the programmer who gets to pick the right level of
# documentation, not the rules of the language. If you are writing simple,
# obvious code, you can be very minimalistic. Alternatively, if you are building
# something complex, you can be more elaborate. Dynamic typing allows you to
# document your code to exactly the level you think is best. It’s your job to do
# the thinking

# So how do you take advantage of dynamic typing? First, don’t create more
# infrastructure than you really need. Keep in mind that Ruby classes don’t need
# to be related by inheritance to share a common interface; they only need to
# support the same methods. Don’t obscure your code with pointless checks to see
# whether this really is an instance of that. Do take advantage of the terseness
# provided by dynamic typing to write code that simply gets the job done with as
# little fuss as possible—but also keep in mind that someone (possibly you!) will
# need to read and understand the code in the future.

# There are a lot of different ways that Ruby objects can be equal, and that all
# these definitions of equality are rooted firmly in helping you make your
# objects behave the way you want them to behave.

# The question is, equal in what sense? It turns out that Ruby’s Object class
# defines no less than four equality methods. There is eql? and equal? as well
# as == (that’s two equal signs), not to mention === (that’s three equal signs).

# Ruby uses the equal? method to test for object identity. In other words, the
# only way that this:

x.equal?(y)

# Should ever return true is if x and y are both references to identically same
# objects. If x and y are different objects, then equal? should always return
# false, no matter how similar x and y might be.

# Each equality method has its purpose, some are used in case statements, others
# are used within Hashes, etc.

# Exclusive or Operator (^) - XOR gate or XOR Boolean operator. It seems that
# different values return true?... BUT it works differently depending on the
# class of the thing that you are using it on... hopefully I don't have to use
# it as it is super confusing! I believe it has to do with binaries when it
# comes to integers. And it doesn't work on strings. Nor Arrays. Nor Hashes.

true ^ false
# => true
true ^ true
# => false

# You also have the <=> operator.

a <=> b

# Should evaluate to -1 if a is less than b, 0 if they are equal, and 1 if a is
# greater than b. The <=> is a boon when you are trying to sort a collection of
# objects.

# The key to getting it right is to keep in mind that Ruby has a fairly fine
# grained model of equality—we have the equal? method, strictly for object
# identity. We have the everyday equality method, ==, and we also have the ===
# method, which comes out mostly for case statements. We also have eql?, and its
# friend hash, to cope with hash tables. Getting object equality right is all
# about understanding the differences between all those methods and overriding
# the right ones.

# If you want to know that your code works, you need to test it. You need to
# test it early, you need to test it often, and you certainly need to test it
# whenever you change it.

# Test::Unit comes packaged with Ruby itself and is a member of the so called
# XUnit family of testing frameworks, so called because there is a similar one
# for virtually every programming language out there.

# In Test::Unit, each test is packaged in a method whose name needs to begin
# with test_.

# Kicking off a Test::Unit test is about as easy as it comes: Just run the file
# containing the test class with Ruby.

# ruby document_test.rb on the terminal for example.

# Rspec, possibly the Ruby world’s favorite testing framework, tries to get us
# to that more perfect world where we test the behavior itself.

# RSpec tries to weave a sort of pseudo-English out of Ruby. We don’t assert
# things; we say that they should happen (although should is a little bit old,
# now we expect things to happen).

# By convention, your RSpec code—generally just called a spec—goes in a file
# called <<class name>>_spec.rb

# A very handy feature of the spec command is its ability to hunt down all of
# the spec files in a whole directory tree, assuming that you follow the
# <<class name>>_spec.rb convention.

# Programs tend to be complicated ecosystems, with the majority of classes
# relying on the kindness of other classes. Because of this, what you need are
# Stubs and Mocks.

# A stub is an object that implements the same interface as one of the
# supporting cast members, but returns canned answers when its methods are
# called. With stub there are no classes to create, no methods to code; stub
# does it all for you (you pretty much fake it).

# A Mock is a stub with an atittude. Along with knowning what canned responses
# to return, a mock also knows which methods should be called and with what
# arguments. Thus, while a stub is there purely to get the test to work, a mock
# is an active participant in the test, watching how it is treated and failing
# the test if it doesn't like what it sees.

# RSpec defines a little expectation language that you can use to express
# exactly what should happen. In addition to declaring that some method will or
# will not be called, you can also specify what arguments the method should see,
# RSpec will check these expectations at the end of each example, and if they
# aren't met the spec will fail.

# An important part of writing a test is making sure that it actually tests what
# you think it tests.

# Write really good tests if you can. Write OK ones if that's all you can do. if
# you can't do anything else, at least write some tests that exercise your code,
# even just a little bit.

# You are not finished until you have both the software and the tests or specs
# to go with it. Write the tests first, or second, or third. But write the
# darned tests.

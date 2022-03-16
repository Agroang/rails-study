# Most Ruby programmers favor very short methods, methods that stick to doing
# one thing, and doing it well. Breaking your code up into many short, single-
# purpose methods not only plays to the strengths of Ruby programming language
# but also makes your whole application more testable.

# Let's say that we have a text compressor class that compress a text into
# two arrays of unique words and the index of the word.

class TextCompressor
  attr_reader :unique, :index

  def initialize(text)
    @unique = []
    @index = []

    words = text.split
    words.each do |word|
      i = @unique.index(word)
      if i
        @index << i
      else
        @unique << word
        @index << unique.size -1
     end
    end
  end
end

text = "This specification is the spec for a specification"
compressor = TextCompressor.new(text)

unique_word_array = compressor.unique
word_index = compression.index

# The above class works as intended but is hard to guess for someone that did
# not build it. The ideal would be to abstract it into smaller methods that
# explain what they do easily to the reader.

class TextCompressor
  attr_reader :unique, :index

  def initialize(text)
    @unique = []
    @index = []

    add_text(text)
  end

  def add_text(text)
    words = text.split
    words.each { |word| add_word(word) }
  end

  def add_word(word)
    i = unique_index_of(word) || add_unique_word(word)
    @index << i
  end

  def unique_index_of(word)
    @unique.index(word)
  end

  def add_unique_word(word)
    @unique << word
    unique.size -1
  end
end

# What was done to the above class is called "composed method" technique. This
# technique advocates dividing your class up into methods that have three
# characteristics.
# 1 - Each method should do a single thing, focus on solving a single aspect of
# the problem.
# 2 - Each method needs to operate at a single conceptual level. Don't mix high
# level logic with the nitty-gritty detail.
# 3 - Each method needs a name that reflects its purpose.

# It's not about writing better code for the computer, because the computer
# doesn't care. The reason you should lean toward smaller methods is that all
# those compact, easy-to-comprehend methods will help you get the details right.

# In Ruby, the cost of defining a new method is very low: just an additional def
# and an extra end. Since defining a new Ruby method adds very little noise to
# your code, in Ruby you can get the full composed method bang for a very modest
# code overhead buck.

# Having many fine-grained methods also tends to make your classes easier to
# test.

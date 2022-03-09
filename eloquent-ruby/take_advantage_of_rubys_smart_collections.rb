# Being elegant when writing arrays and hashes is important, and Ruby allows
# us to avoid being literal when writing both.

poem_words = [ 'twinkle', 'little', 'star', 'how', 'I', 'wonder' ]

# Recommended way (regular ()/[] also work, but the correct seems to be {}):
poem_words = %w{ twinkle little star how I wonder }

# Hahes also should avoid the hash rocket (=>) and try to use newer syntax:

book_info = { :first_name => 'Russ', :last_name => 'Olsen' }

# Better version:
book_info = { first_name: 'Russ', last_name: 'Olsen' }

# There are other interesting options when using %, for example

poem_words = %{ twinkle little star how I wonder }
# => "twinkle little star how I wonder" // double quotes

poem_words = %q{ twinkle little star how I wonder }
# => 'twinkle little star how I wonder' // single quotes

poem_words = %s{ twinkle little star how I wonder }
# => :twinkle little star how I wonder

array = %i(Ruby Python PHP)
# => [:Ruby, :Python, :PHP]

random = %s{ hello }
# => :hello

# Another way of creating Arrays and Hashes is to use methods to do the job for
# you.

def echo_all( *args )
  args.each { |arg| puts arg }
end

echo_all("1", 2, 3, 4)
# => it puts into the console but also returns ["1", 2, 3, 4]

# Another interesting way of using the splat operator (*):

def echo_at_least_two( first_arg, *middle_args, last_arg )
  puts "The first argument is #{first_arg}"
  middle_args.each { |arg|puts "A middle argument is #{arg}" }
  puts "The last argument is #{last_arg}"
end

echo_at_least_two(1, 2, 3, 4, 5, 6)
# returns nil but puts the following on the terminal:
# The first argument is 1
# A middle argument is 2
# A middle argument is 3
# A middle argument is 4
# A middle argument is 5
# The last argument is 6

# An interesting way of using an array as an argument:

def add_authors( names )
  @author += " #{names.join(' ')}"
end

doc.add_authors( [ 'Strunk', 'White' ] )

# But is still better and more convenient to actually use the splat operator
# (clearer and less code)

def add_authors( *names )
  @author += " #{names.join(' ')}"
end

doc.add_authors( 'Strunk', 'White' )

# When it comes to Hashes, you have similar ways to help reduce the lines and
# make the code easier to understand.

def load_font( specification_hash )
  # Load a font according to specification_hash[:name] etc.
end

load_font( { :name => 'times roman', :size => 12 })

# When a Hash is the last argument of a method call, you can OMIT the {} making
# the code shorter:

load_font( :name => 'times roman', :size => 12 )

# You can go even further and something like:

load_font :name => 'times roman', :size => 12

# I BELIEVE you can go and also use newer syntax, like:
# (at least it's working on the terminal)

load_font name: 'times roman', size: 12

# When it comes to interation over collections, the prefered method is #each

words = %w{ Mary had a little lamb }
words.each { |word| puts word }

# In the case of Hashes, depending on the way you use the block, you get the
# pairs of key/values

movie = { title: '2001', genre: 'sci fi', rating: 10 }
movie.each { |entry| pp entry }
# [:title, "2001"]
# [:genre, "sci fi"]
# [:rating, 10]]

# At the same time, to make things a little bit easier to understand, you can
# provide two values to the block instead of one

movie.each { |name, value| puts "#{name} => #{value}"}

# The other two really useful methods are #map and #inject
# The map method is incredibly useful for transforming the contents of a
# collection en mass. For example, if you wanted an array of all the word
# lengths, you might turn to map:

pp doc.words.map { |word| word.size }

# Which would print:
[3, 5, 2, 3, 4]

# Or maybe have the lower case versions of the words?
lower_case_words = doc.words.map { |word| word.downcase }

# The #inject method is a little bit harder to grasp....but super useful once
# you get to understand it.

# Like each, inject takes a block and calls the block with each element of the
# collection. Unlike each, inject passes in two arguments to the block: Along
# with each element, you get the current result—the current sum if you are adding
# up all of the word lengths. Each time inject calls the block, it replaces the
# current result with the return value of the previous call to the block. When
# inject runs out of elements, it returns the result as its return value.

# Version using #each:

def average_word_length
  total = 0.0
  words.each { |word| total += word.size }
  total / word_count
end

# Version using #inject:

def average_word_length
  total = words.inject(0.0){ |result, word| word.size + result}
  total / word_count
end

# The argument passed into inject (0.0 in the example) is the initial value of
# the result. If you don’t supply an initial value, inject will skip calling the
# block for the first element of the array and simply use that element as the
# initial result.

# One thing to be careful is to know which methods return a copy of the
# collection without modifying it. In the sense you also need to be careful with
# methods that include bang(!) is those in most cases modify the original
# collection.

# Arrays and Hahes (quite unique to Ruby) are also ordered, so if you print them
# they will appear in the order that the take place inside the collection.
# Even if you modify the value, the order won't change.

# Arrays and Hashes are incredibly useful, so useful that sometimes we just
# stick with them, when we could be using also other available collections
# such as Set for example (array like object that only allows unique elements,
# no duplication allowed, quite handy).

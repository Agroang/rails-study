# For an external DSL you need to build a parser as well.

# Since the whole idea of internal DSLs is that the DSL code is Ruby, you cannot
# build an internal DSL able to cope with syntax that is not Ruby syntax.

# .eof? is a method to check if it's the "end of file", returns true if it is.
# (using it with the EzRipper example from the book)

class EzRipper
  def initialize( program_path )
    @ripper = XmlRipper.new
    parse_program(program_path)
  end

  def run( xml_file )
    @ripper.run( xml_file )
  end

  def parse_program( program_path )
    File.open(program_path) do |f|
      until f.eof?
        parse_statement( f.readline )
      end
    end
  end

  def parse_statement( statement )
    tokens = statement.strip.split
    return if tokens.empty?
    case tokens.first
    when 'print'
      @ripper.on_path( tokens[1] ) do |el|
        puts el.text
      end
    when 'delete'
      @ripper.on_path( tokens[1] ) { |el| el.remove }
    when 'replace'
      @ripper.on_path( tokens[1] ) { |el| el.text = tokens[2] }
    when 'print_document'
      @ripper.after do |doc|
        puts doc
      end
    else
      raise "Unknown keyword: #{tokens.first}"
    end
  end
end

# The EzRipper class really just provides a fancy front end for the original
# XmlRipper class. All of the real XML processing work is still done by
# XmlRipper. The parser reads in a line at a time—we are assuming that each
# statement fits on a single line—and breaks up the statement into
# space-separated tokens using the handy String split method.

# The current implementation of EzRipper does have one potentially serious
# limitation: It can’t handle spaces in the command arguments.

replace '/document/author' 'Russ Olsen' # => Won't work with the above version

# This situation calls for some regular expressions. Here’s a new
# parse_statement method, one that uses regular expressions to cope with the
# more complex syntax:

def parse_statement( statement )
  statement = statement.sub( /#.*/, '' )
  case statement.strip
  when ''
    # Skip blank lines
  when /print\s+'(.*?)'/
    @ripper.on_path( $1 ) do |el|
      puts el.text
    end
  when /delete\s+'(.*?)'/
    @ripper.on_path( $1 ) { |el| el.remove }
  when /replace\s+'(.*?)'\s+'(.*?)'$/
    @ripper.on_path( $1 ) { |el| el.text = $2 }
  when /uppercase\s+'(.*?)'/
    @ripper.on_path( $1 ) { |el| el.text = el.text.upcase }
  when /print_document/
    @ripper.after do |doc|
      puts doc
    end
  else
    raise "Don't know what to do with: #{statement}"
  end
end

# There is no doubt that the regular expression-based parser is more complicated
# than our original “just pull things apart with split” approach. It’s the price
# you pay for a more complex syntax.

# As your external DSL gets more and more complex, at some point it’s going to
# overwhelm your ability to write and, more importantly, read, the regular
# expressions required to handle the grammar. If you do get to that stage, the
# thing to do is to turn to a real parser-building tool.

# One of these tools is "Treetop".

# With an internal DSL, you get all of Ruby, complete with comments, loops, if
# statements, and variables more or less for free. With an external DSL, you need
# to work for—or at least parse—every feature.

# The line between internal and external DSLs is not really all that sharp, you
# can use plain Ruby in an external DSL.

# ERB is an example of an external DSL!

# Simple or complex, external DSLs free you from the constraints of Ruby syntax.
# But external DSLs also relieve you of that free Ruby parser. If you need to
# build a DSL, the choice is up to you: Do you take the ease and relative low
# cost of an internal DSL or go for the higher cost—and freedom—of an external
# DSL?

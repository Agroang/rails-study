# A really useful feature of the gem system is its complete versioning support.
# Every gem is tagged with a version number and, since coders are forever fixing
# bugs and adding features, most gems exist in multiple versions.

# There are only two key things you need to do to create a gem. The first is to
# organize your project directories to match the standard gem layout.
# The second thing is the metadata. We need to tell RubyGems the name of our gem,
# its version and the like. We do this by creating a gemspec file. A gemspec
# file is nothing more than a file full of Ruby code that creates an instance of
# the Gem::Specification class.

# Example:

Gem::Specification.new do |s|
  s.name = "document"
  s.version = "1.0.1"
  s.authors = ["Russ Olsen"]
  s.date = %q{2010-01-01}
  s.description = 'Document - Simple document class'
  s.summary = s.description
  s.email = 'russ@russolsen.com'
  s.files = ['README', 'lib/document.rb','spec/document_spec.rb']
  s.homepage = 'http://www.russolsen.com'
  s.has_rdoc = true
  s.rubyforge_project = 'simple_document'
  s.add_dependency('text' )
end

# Once you have all of your Ruby files in place under lib, your README file
# written, and your gemspec file built, creating the actual gem file is easy:
# Just run the gem build command and call out the gemspec file:

gem build document.gem

# This command will create a file called document-1.0.1.gem, a tidy little
# package of document goodness. You can install your new gem on your system by
# simply specifying the gem file:

gem install document-1.0.1.gem

# If you need to make your gem available to the general public, then you need
# to upload your gem to a repository.
# Under the covers, the gem command turns to http://gems.rubyforge.org when it
# goes looking for gems to install. Behind this URL is the open source project,
# Gemcutter, which is devoted to being the place to get gems. Getting your gem
# into the Gemcutter repository could not be easier. You only need to go to
# http:// gemcutter.org and set up a free account. You will also need to install
# the gemcutter gem:

gem install gemcutter

# Now you are ready to push your gem up to the Gemcutter repository:

gem push document-1.0.0.gem

# The push command will ask for your Gemcutter account information and then
# upload your gem to the repository.

# You could automate the whole thing with a rake task, this Rakefile takes
# advantage of the built-in tasks that will build a gem for you. All
# you need to do is specify the gemspec information in the Rakefile.

require 'spec/rake/spectask'
require 'rake/gempackagetask'

task :default => [ :spec, :gem ]

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end

gem_spec = Gem::Specification.new do |s|
  s.name = "document"
  s.version = "1.0.1"
  s.authors = ["Russ Olsen"]
  s.date = %q{2010-05-23}
  s.description = 'Document - Simple document class'
  s.summary = s.description
  s.email = 'russ@russolsen.com'
  s.files = ['README','lib/document.rb', 'spec/document_spec.rb']
  s.homepage = 'http://www.russolsen.com'
  s.has_rdoc = true
  s.rubyforge_project = 'simple_document'
end

Rake::GemPackageTask.new( gem_spec ) do |t|
  t.need_zip = true
end

task :push => :gem do |t|
  sh "gem push pkg/#{gem_spec.name}-#{gem_spec.version}.gem"
end

# Often problems when creating a gem are name collisions, no declaration of
# dependencies, and path problems (use absolute paths with __FILE__)
# => File.read( "#{File.dirname(__FILE__)}/times_roman_12.font")

# The message here is that you should always test your gems in as realistic a
# setting as possible.

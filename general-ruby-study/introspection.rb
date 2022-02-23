class Greeting
  def initialize(text)
    @text = text
  end
  def welcome
    @text
  end
end

my_object = Greeting.new('Hello')

my_object.class # Greeting

my_object.class.instance_methods(false) # [:welcome]
# the false here allows us to only show the instance methods defined by itself,
# no isntance methods inherited from another class

my_object.instance_variables # [:@text]

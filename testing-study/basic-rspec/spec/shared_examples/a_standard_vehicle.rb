shared_examples_for('a standard vehicle') do

 describe 'attributes' do

    # adding a before hook for examples, in this case we use example and not
    # describe because we are changing values and those would remain for
    # describe/context as it would be using the same variable, commenting
    # out the old variable just to remember what we did before.

    # before(:example) do
    #   # we must use an instance variable to be available to the examples
    #   @car = Car.new
    # end

    # "let" is better than "before" for setting up instance variables, so I
    # commented out the above.

    # let(:car) { Car.new }
    # because we commented out the "before" method we are no longer using
    # those instace variables so I changed the bellow code accordingly,
    # otherwise it would still be something like @car.make = 'Test'

    # use "subject" instead of "let" if variable is subject of example
    # we will replace  let(:car) { Car.new } with subject { Car.new }
    # there is no correct, but subject will stand out and will make a difference
    # from other "let" variables that you may be using, both are correct

    # we don't need subject explicitly-defined if we use a classname after
    # describe, so we can comment out bellow
    # subject { Car.new }

    it 'allows reading and writing for :make' do
      # car = Car.new
      # changing "car" to "subject" as we are replace "let" with "subject"
      subject.make = 'Test' # writing here
      expect(subject.make).to eq('Test') # reading here
    end

    it 'allows reading and writing for :year' do
      # car = Car.new
      subject.year = 9999
      expect(subject.year).to eq(9999)
    end

    it 'allows reading and writing for :color' do
      # car = Car.new
      subject.color = 'foo'
      expect(subject.color).to eq('foo')
    end

    it 'allows reading for :wheels' do # only attribute reader set on the class
      # car = Car.new
      expect(subject.wheels).to eq(4)
    end

    it 'allows writing for :doors' # without the do/end it will become 'pending'
  end
end

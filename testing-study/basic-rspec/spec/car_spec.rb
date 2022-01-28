require 'car'

describe 'Car' do

  describe 'attributes' do

    # adding a before hook for examples, in this case we use example and not
    # describe because we are changing values and those would remain for
    # describe/context as it would be using the same variable, commenting
    # out the old variable just to remember what we did before.

    before(:example) do
      # we must use an instance variable to be available to the examples
      @car = Car.new
    end

    it 'allows reading and writing for :make' do
      # car = Car.new
      @car.make = 'Test' # writing here
      expect(@car.make).to eq('Test') # reading here
    end

    it 'allows reading and writing for :year' do
      # car = Car.new
      @car.year = 9999
      expect(@car.year).to eq(9999)
    end

    it 'allows reading and writing for :color' do
      # car = Car.new
      @car.color = 'foo'
      expect(@car.color).to eq('foo')
    end

    it 'allows reading for :wheels' do # only attribute reader set on the class
      # car = Car.new
      expect(@car.wheels).to eq(4)
    end

    it 'allows writing for :doors' # without the do/end it will become 'pending'
  end

  describe '.colors' do

    it 'returns an array of color names' do
      c = ['blue', 'black', 'red', 'green']
      expect(Car.colors).to match_array(c) # Class method
    end
  end

  describe '#full_name' do

    it 'returns a string in the expected format' do
      @honda = Car.new(make: 'Honda', year: 2004, color: 'blue')
      expect(@honda.full_name).to eq ('2004 Honda (blue)')
    end

    context 'when initialized with no arguments' do # so, 'in this context' then
      it 'returns a string using default values' do
        car = Car.new
        expect(car.full_name).to eq('2007 Volvo (unknown)')
      end
    end
  end
end

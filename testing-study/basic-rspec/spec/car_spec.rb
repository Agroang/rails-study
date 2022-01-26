require 'car'

describe 'Car' do
  describe 'attributes' do

    it 'allows reading and writing for :make' do
      car = Car.new
      car.make = 'Test' # writing here
      expect(car.make).to eq('Test') # reading here
    end

    it 'allows reading and writing for :year' do
      car = Car.new
      car.year = 9999
      expect(car.year)to. eq(9999)
    end

    it 'allows reading and writing for :color' do
      car = Car.new
      car.color = 'foo'
      expect(car.color).to eq('foo')
    end

    it 'allows reading for :wheels' do # only attribute reader set on the class
      car = Car.new
      expect(car.wheels).to eq(4)
    end
  end

  describe '.colors' do

    it 'returns an array of color names' do
      c = ['blue', 'black', 'red', 'green']
      expect(Car.colors).to match_array(c) # Class method
    end
  end

  describe '#full_name' do

    if 'returns a string in the expected format' do
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

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

    it 'allows reading for :wheels' do
      car = Car.new
      expect(car.wheels).to eq(4)
    end
  end

  describe '.colors' do


  end

  describe '#full_name' do

  end
end

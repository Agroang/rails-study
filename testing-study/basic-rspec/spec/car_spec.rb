require 'car'
require 'shared_examples/a_standard_vehicle'

# changing 'Car' to Car to use the actual classname and not string, that way
# we get a implict subject and there is no need to define the subject
# describe 'Car' do
describe Car do

  # commented out describe 'attributes' as we have it as shared example
  it_behaves_like('a standard vehicle')

  # describe 'attributes' do

  #   # adding a before hook for examples, in this case we use example and not
  #   # describe because we are changing values and those would remain for
  #   # describe/context as it would be using the same variable, commenting
  #   # out the old variable just to remember what we did before.

  #   # before(:example) do
  #   #   # we must use an instance variable to be available to the examples
  #   #   @car = Car.new
  #   # end

  #   # "let" is better than "before" for setting up instance variables, so I
  #   # commented out the above.

  #   # let(:car) { Car.new }
  #   # because we commented out the "before" method we are no longer using
  #   # those instace variables so I changed the bellow code accordingly,
  #   # otherwise it would still be something like @car.make = 'Test'

  #   # use "subject" instead of "let" if variable is subject of example
  #   # we will replace  let(:car) { Car.new } with subject { Car.new }
  #   # there is no correct, but subject will stand out and will make a difference
  #   # from other "let" variables that you may be using, both are correct

  #   # we don't need subject explicitly-defined if we use a classname after
  #   # describe, so we can comment out bellow
  #   # subject { Car.new }

  #   it 'allows reading and writing for :make' do
  #     # car = Car.new
  #     # changing "car" to "subject" as we are replace "let" with "subject"
  #     subject.make = 'Test' # writing here
  #     expect(subject.make).to eq('Test') # reading here
  #   end

  #   it 'allows reading and writing for :year' do
  #     # car = Car.new
  #     subject.year = 9999
  #     expect(subject.year).to eq(9999)
  #   end

  #   it 'allows reading and writing for :color' do
  #     # car = Car.new
  #     subject.color = 'foo'
  #     expect(subject.color).to eq('foo')
  #   end

  #   it 'allows reading for :wheels' do # only attribute reader set on the class
  #     # car = Car.new
  #     expect(subject.wheels).to eq(4)
  #   end

  #   it 'allows writing for :doors' # without the do/end it will become 'pending'
  # end

  it 'allows reading and writing for :doors' do
    subject.doors = 1
    expect(subject.doors).to eq(1)
  end

  describe '#initialize' do
    it 'defaults to 4 doors' do
      expect(subject.doors).to eq(4)
    end

    it 'allows setting a new number of doors' do
      car = Car.new(:doors => 2)
      expect(car.doors).to eq(2)
    end

    it 'defaults to 4 if option is neither 2 or 4' do
      door_count = []
      [0, 1, 3, 5, 6].each do |n| # just targeting some numbers, but not 2 or 4
        car = Car.new(:door => n)
        door_count << car.doors
      end
      expect(door_count).to all(eq(4)) # each value to eq 4
    end
  end

  describe '.colors' do
    # c = ['blue', 'black', 'red', 'green'] changing this to use "let"
    let(:colors) { ['blue', 'black', 'red', 'green'] }
    it 'returns an array of color names' do
      # c = ['blue', 'black', 'red', 'green']
      expect(Car.colors).to match_array(colors) # Class method
    end
  end

  describe '#full_name' do
    # chaging this @honda = Car.new(make: 'Honda', year: 2004, color: 'blue')
    # to use "let" method
    let(:honda) { Car.new(make: 'Honda', year: 2004, color: 'blue') }

    it 'returns a string in the expected format' do
      # @honda = Car.new(make: 'Honda', year: 2004, color: 'blue')
      expect(honda.full_name).to eq ('2004 Honda (blue)')
    end

    # changing car = Car.new to use "let" helper
    let(:new_car) { Car.new }
    context 'when initialized with no arguments' do # so, 'in this context' then
      it 'returns a string using default values' do
        # car = Car.new
        expect(new_car.full_name).to eq('2007 Volvo (unknown)')
      end
    end
  end

  describe '#coupe?' do
    it 'returns true if it has 2 doors' do
      car = Car.new(:doors => 2)
      expect(car.coupe?).to be true
    end

    it 'returns false if it does not have 2 doors' do
      car = Car.new(:doors => 4)
      expect(car.coupe?).to be false
    end
  end

  describe '#sedan?' do
    it 'returns true if it has 4 doors' do
      car = Car.new(:doors => 4)
      expect(car.sedan?).to be true
    end

    it 'returns false if it does not have 4 doors' do
      car = Car.new(:doors => 2)
      expect(car.sedan?).to be false
    end
  end
end

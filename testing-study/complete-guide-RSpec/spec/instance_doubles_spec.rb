class Person
  def a
    'Hello'
  end
end

RSpec.describe Person do
  describe 'regular double' do
    it 'can implement any method' do
      # this is not very close to the real thing, it has an extra method, so it
      # creates polution, that is why we need something a little bit more strict
      # that only allow us to create a double that has the same methods as the
      # real thing (bellow is the "bad" example)
      person = double(a: 'Hello', b: 20)
      expect(person.a).to eq('Hello')
    end
  end

  # an instance double is a "verifying double", a double that really mimicks
  # the behaviour of a real object and is stricter then the regular double
  describe 'instance double' do
    it 'can only implement methods that are defined on the class' do
      person = instance_double(Person, a: 'Hello')
      # person = instance_double(Person, a: 'Hello', b: 20) # would break
      # NOT a double of the class but of the instances of the class, if we pass
      # a method above that the instances of the class do not have it will throw
      # an error before even checking the examples

      # person = instance_double(Person)
      # allow(person).to receive(:a).with(3, 10).and_return('Hello')
      # the above also wouldn't work, because is saying that you will call #a
      # with the arguments of 3 and 10 and #a does not expect any arguments
      expect(person.a).to eq('Hello')
    end
  end
end

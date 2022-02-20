RSpec.describe '#even? number method' do
  # by convention for instance methods we use #method and for class methods we
  # use .method
  describe 'with even numbers' do # you can use 'context' instead of describe
    it 'returns true' do
      expect(4.even?).to eq(true)
    end
  end
  # you can have as many context/describe nested as needed, the logic is that if
  # you are describing too much on the 'it' method then probably you need to
  # use a context/describe to abstract and make 'it' simpler.
  describe 'with odd numbers' do
    it 'returns false' do
      expect(7.even?).to eq(false)
    end
  end
end

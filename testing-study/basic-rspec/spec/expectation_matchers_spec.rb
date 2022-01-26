# you usually don't make standalone files like this, this is for practice

describe 'Expectation Matchers' do

  describe 'equivalence matchers' do

    it 'will match loose equality with #eq' do
      a = "2 cats"
      b = "2 cats"
      expect(a).to eq(b)
      expect(a).to be == b # synonym for #eq

      c = 17
      d = 17.0
      expect(c).to eq(d) # different types, but "close enough"
    end

    it 'will match value equality with #eql' do
      a = "2 cats"
      b = "2 cats"
      expect(a).to eql(b) # just a little stricter

      c = 17
      d = 17.0
      expect(a).not_to eql(d) # not the same, close doesn't count
    end

    it 'will match identity equality with #equal' do
      a = "2 cats"
      b = "2 cats"
      expect(a).not_to equal(b) # same value but different object

      c = b
      expect(b).to equal(c) # same object
      expect(b).to be(c) # synonym for #equal
    end
  end

  describe 'truthiness matchers' do

    it 'will match true/false' do
      expect(1 < 2).to be(true) # do not use 'be_true'
      expect(1 > 2).to be(false) # do not use 'be_false'

      expect('foo').not_to be(true) # string is not exactly true, it's truthy
      expect(nil).not_to be(false) # nil is not exactly false, it's falsey
      expect(0).not_to be(false) # 0 is not exactly false, it's falsey
    end

    it 'will match truthy/falsey' do
      expect(1 < 2).to be_truthy
      expect(1 > 2).to be_falsey

      expect('foo').to be_truthy # any value count as truthy
      expect(nil).to be_falsey # nil count as false
      expect(0).not_to be_falsey # but 0 is still not falsey enough!
    end

    it 'will match nil' do
      expect(nil).to be_nil
      expect(nil).to be(nil) # same as above

      expect(false).not_to be_nil # nil only, just like .nil?
      expect(0).not_to be_nil # nil only, just like .nil?
    end
  end

  describe 'numeric comparison matchers' do

    it 'will match less than/greater than' do
      expect(10).to be > 9
      expect(10).to be >= 10
      expect(10).to be <= 10
      expect(9).to be < 10
    end

    it 'will match numeric ranges' do
      expect(10).to be_between(5, 10).inclusive
      expect(10).not_to be_between(5, 10).exclusive
      expect(10).to be_within(1).of(11)
      expect(5..10).to cover(9)
    end
  end

  describe 'collection matchers' do

    it 'will match arrays'do
      array = [1, 2, 3]

      expect(array).to include(3)
      expect(array).to include(1, 3)

      expect(array).to start_with(1)
      expect(array).to end_with(3)

      expect(array).to match_array([3, 2, 1])
      expect(array).not_to match_array([1, 2])

      expect(array).to contain_exactly(3, 2, 1) # similar to match_array
      expect(array).not_to contain_exactly(1, 2) # but uses individual args
    end

    it 'will match strings' do
      string = 'some string'

      expect(string).to include('ring')
      expect(string).to include('so', 'ring')
      expect(string).to include('s', 'm')
      expect(string).not_to include('z')

      expect(string).to start_with('so')
      expect(string).to start_with('s')
      expect(string).to end_with('ring')
      expect(string).to end_with('g')
    end

    it 'will match hashes' do
      hash = {:a => 1, :b => 2, :c => 3}
      new_hash = {a: 1, b: 2, c: 3}

      expect(hash).to include(:a)
      expect(hash).to include(:a => 1)
      expect(new_hash).to include(:a) # this one doesn't work like bellow
      expect(new_hash).to include(a: 1) # works with new syntax

      expect(hash).to include(:a => 1, :c => 3)
      expect(hash).to include({:a => 1, :c => 3})
      expect(new_hash).to include(a: 1, c: 3) # more than 1 also works with new
      expect(new_hash).to include({a: 1, c: 3}) # syntax

      expect(hash).not_to include({'a' => 1, 'c' => 3}) # in RoR the 'a' would
      # work for the symbol a:, but in pure ruby it won't
      expect(new_hash).not_to include ({'a'=> 1, 'c'=> 3}) # doesn't work as
      # 'a' : 1
    end
  end
end

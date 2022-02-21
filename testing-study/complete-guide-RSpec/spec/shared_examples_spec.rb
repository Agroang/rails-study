RSpec.shared_examples 'a Ruby object with three elements' do
  it 'returns the number of items' do
    expect(subject.length).to eq(3)
  end
end

RSpec.describe Array do
  subject { [1, 2, 3] }

  # it 'returns the number of items' do # normal way, not DRY
  #   expect(subject.length).to eq(3)
  # end
  include_examples 'a Ruby object with three elements' # better, DRY, if you
  # are testing the same thing, share those examples. Usually you have a
  # separate file where you put those and you import it later (examples on
  # the linkedin tutorial memo/repo)
end

RSpec.describe Hash do
  subject {{ a: 1, b: 2, c: 3 }}

  # it 'returns the number of items' do # normal way, not DRY
  #   expect(subject.length).to eq(3)
  # end
  include_examples 'a Ruby object with three elements'
end

RSpec.describe String do
  subject { 'abc' }

  # it 'returns the number of items' do # normal way, not DRY
  #   expect(subject.length).to eq(3)
  # end
  include_examples 'a Ruby object with three elements'
end

class RandomTest
  def length
    3
  end
end

RSpec.describe RandomTest do
  # it 'returns the number of items' do # normal way, not DRY
  #   expect(subject.length).to eq(3)
  # end
  include_examples 'a Ruby object with three elements'
end

RSpec.describe 'satisfy matcher' do
  subject { 'racecar' } # palindrome, racecar reads the same reversed

  it 'is a palindrome' do
    expect(subject).to satisfy { |value| value == value.reverse }
  end

  it 'can accept a custom failing message' do # better for everyone to understand
    expect(subject).to satisfy('be a palindrome') { |value| value == value.reverse }
  end

  it { is_expected.to satisfy { |value| value == value.reverse } }
  it { is_expected.to satisfy('be a palindrome') { |value| value == value.reverse } }
  # as long as the block provided to satisfy returns a boolean value, then the
  # block with work with the satisfy matcher
end

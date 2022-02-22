RSpec.describe 'not_to method' do
  it 'checks for the inverse of a matcher' do
    expect(5).not_to eq(6)
    expect([1, 2, 3]).not_to equal([1, 2, 3])
    expect(10).not_to be_odd
    expect([1, 2, 3]).not_to be_empty
    expect(nil).not_to be_truthy
    expect('Pizza').not_to start_with('pi')
    expect('Hot Pepper').not_to end_with('ir')
    expect(5).not_to respond_to(:length)
    expect([1, 2, 3]).not_to include(4)
    expect { 4/3 }.not_to raise_error # when using not_to + raise_error is
    # better to leave without passing the possible expected error to avoid
    # false positives, this will fail if any kind of error is raised, instead
    # of checking for a specific error
  end
end

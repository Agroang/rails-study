RSpec.describe 'all matcher' do
  it 'allows for aggregate checks' do
    # this is what RSpec is doing under the hood, keeping commented out for
    # reference:
    # [5, 7, 9].each do |val|
    #   expect(val).to be_odd
    # end

    expect([5, 7, 9]).to all(be_odd) # you pass predicate matcher or comparison
    expect([2, 4, 6, 8]).to all(be_even)
    expect([0, 0]).to all(be_zero)
    expect([[], [], []]).to all(be_empty)
    expect([5, 7, 9]).to all(be < 10)
  end

  describe [5, 7, 9] do # testing with one-liner syntax as well
    it { is_expected.to all(be_odd) }
    it { is_expected.to all(be < 10) }
  end
end

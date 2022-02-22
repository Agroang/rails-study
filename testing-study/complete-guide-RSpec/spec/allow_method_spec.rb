RSpec.describe 'allow method review' do
  it 'can customize return value for methods on doubles' do
    calculator = double #very simple double
    allow(calculator).to receive(:add).and_return(6)

    expect(calculator.add).to eq(6)
    expect(calculator.add(1, 3)).to eq(6) # doesn't matter what we pass, it will
    # always return 6, that the setup that we provided to it
  end

  it 'can stub one or more methods on real objects' do
    arr = [1, 2, 3]
    allow(arr).to receive(:sum).and_return(10) # stubbing a real arr method, and
    # now even though there is a real #sum method for arrays, ours will return 10

    expect(arr.sum).to eq(10)

    arr.push(4)
    expect(arr).to eq([1, 2, 3, 4])
    # this proves that the other methods that array has haven't been modified,
    # we only changed the #sum method
  end

  it 'can return multiple return values in sequence' do
    mock_array = double
    allow(mock_array).to receive(:pop).and_return(:a, :b, nil)
    # what the above means, is that when you call #pop on mock_array the first
    # time it will return :a, the second :b, and from the third one it will
    # return nil (pop deletes the last element of an array and returns it)
    expect(mock_array.pop).to eq(:a)
    expect(mock_array.pop).to eq(:b)
    expect(mock_array.pop).to be_nil # from third and beyond will be nil
    expect(mock_array.pop).to be_nil
    expect(mock_array.pop).to be_nil
  end
end

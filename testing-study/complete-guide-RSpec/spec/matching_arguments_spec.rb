RSpec.describe 'matching marguments' do
  it 'can return different values depending on the argument' do
    three_element_array = double # mimicking this [1, 2, 3]

    # the #with method allow us to specify exactly what argument we expect
    # to get and what to return in the case we get that argument as the one
    # provided
    # no_args means that "when no arguments are passed"
    allow(three_element_array).to receive(:first).with(no_args).and_return(1)
    # mimicking [1, 2, 3].first (that returns just 1)
    allow(three_element_array).to receive(:first).with(1).and_return([1])
    # if we call [1, 2, 3].first(1) it will return a new array with [1]
    allow(three_element_array).to receive(:first).with(2).and_return([1, 2])
    # if we call [1, 2, 3].first(2) it will return a new array with [1, 2]
    allow(three_element_array).to receive(:first).with(be >= 3).and_return([1, 2, 3])
    # if we call [1, 2, 3].first(3) or any number above 3, it will return a
    # new array with [1, 2, 3]

    expect(three_element_array.first).to eq(1)
    expect(three_element_array.first(1)).to eq([1])
    expect(three_element_array.first(2)).to eq([1, 2])
    expect(three_element_array.first(3)).to eq([1, 2, 3])
    expect(three_element_array.first(10000)).to eq([1, 2, 3])

  end
end
